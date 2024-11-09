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
          homeHostingController.tabBarItem = UITabBarItem(
              title: "Home",
              image: UIImage(systemName: "house"),
              selectedImage: UIImage(systemName: "house.fill")
          )
          
          var cartView = CartView(viewModel: CartViewModel())
          cartView.coordinator = coordinator
          let cartHostingController = UIHostingController(rootView: cartView)
          cartHostingController.tabBarItem = UITabBarItem(
              title: "Carrinho",
              image: UIImage(systemName: "cart"),
              selectedImage: UIImage(systemName: "cart.fill")
          )
          
          viewControllers = [cartHostingController, homeHostingController]
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
