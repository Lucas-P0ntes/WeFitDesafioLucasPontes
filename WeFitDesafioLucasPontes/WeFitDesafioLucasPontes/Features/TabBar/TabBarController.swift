//
//  TabBarController.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController {

    weak var coordinator: CoordinatorFlowController?
    private var selectionLayer = CALayer()
    private var gradientLayer = CAGradientLayer()

    private let tabBarBackgroundColor = UIColor(red: 25/255, green: 25/255, blue: 35/255, alpha: 1.0)
    private let indicatorHeight: CGFloat = 3.0
    private let gradientHeight: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearance()
        setupGradientOverlay()
    }
    
    private func setupTabBar() {
        var homeView = HomeView(viewModel: HomeViewModel())
        homeView.coordinator = coordinator
        let homeHostingController = UIHostingController(rootView: homeView)
        
        var cartView = CartView(viewModel: CartViewModel())
        cartView.coordinator = coordinator
        let cartHostingController = UIHostingController(rootView: cartView)
        
        let viewController = UIViewController()
        
        
        // Create custom Tab Bar items
        let customCartItem = createCustomTabBarItem(title: "Carrinho", imageName: "cart.fill")
        let customHomeItem = createCustomTabBarItem(title: "Home", imageName: "house.fill")
        let customProfileItem = createCustomTabBarItem(title: "Profile", imageName: "house.fill")
        
        // Create container views for custom Tab Bar items
        let cartTabBarItemView = UIView()
        cartTabBarItemView.addSubview(customCartItem)
        
        let homeTabBarItemView = UIView()
        homeTabBarItemView.addSubview(customHomeItem)
        
        let profileTabBarItemView = UIView()
        profileTabBarItemView.addSubview(customProfileItem)
        
        // Set up container views within the Tab Bar
        tabBar.addSubview(cartTabBarItemView)
        tabBar.addSubview(homeTabBarItemView)
        tabBar.addSubview(profileTabBarItemView)
        
        // Position items relative to the tabBar width (distribute evenly)
        let tabBarWidth = self.view.frame.width
        let itemWidth: CGFloat = 100
        let spacing = (tabBarWidth - (itemWidth * 3)) / 4  // Adjust spacing between items

        // Positioning of the custom items
        homeTabBarItemView.frame.origin = CGPoint(x: spacing + itemWidth, y: 0)
        cartTabBarItemView.frame.origin = CGPoint(x: spacing, y: 0)
        profileTabBarItemView.frame.origin = CGPoint(x: spacing + itemWidth * 2, y: 0)
        
        // Defining Tab Bar item sizes
        homeTabBarItemView.frame.size = CGSize(width: itemWidth, height: 50)
        cartTabBarItemView.frame.size = CGSize(width: itemWidth, height: 50)
        profileTabBarItemView.frame.size = CGSize(width: itemWidth, height: 50)
        
        // Set the View Controllers for the Tab Bar
        viewControllers = [cartHostingController, homeHostingController, viewController]
    }
    
    func createCustomTabBarItem(title: String, imageName: String) -> UIView {
        // Create image view
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 24, height: 24)
        
        // Create title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        // Create StackView to contain both image and label
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.frame.size = CGSize(width: 100, height: 50)  // Adjust size as necessary
        
        return stackView
    }

    private func setupTabBarAppearance() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
        tabBar.barTintColor = tabBarBackgroundColor
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = tabBarBackgroundColor
        configureTabBarItemAppearance(appearance)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func configureTabBarItemAppearance(_ appearance: UITabBarAppearance) {
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
    }
    
    private func setupGradientOverlay() {
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1), height: gradientHeight)
        
        selectionLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1), height: indicatorHeight)
        selectionLayer.backgroundColor = UIColor.white.cgColor
        
        tabBar.layer.addSublayer(selectionLayer)
        tabBar.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame.size.width = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateSelectionLayerPosition(animated: true)
    }
    
    private func updateSelectionLayerPosition(animated: Bool) {
        guard let selectedItem = tabBar.selectedItem else { return }
        let selectedIndex = tabBar.items?.firstIndex(of: selectedItem) ?? 0
        let indicatorPositionX = (tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)) * CGFloat(selectedIndex)
        
        let updateFrames = {
            self.selectionLayer.frame.origin.x = indicatorPositionX
            self.gradientLayer.frame.origin.x = indicatorPositionX
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: updateFrames)
        } else {
            updateFrames()
        }
    }
}
