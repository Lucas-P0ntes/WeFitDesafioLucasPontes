//
//  TabBarController.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import  UIKit
import Combine
import SwiftUI

class TabBarController: UITabBarController {
    
    weak var coordinator: CoordinatorFlowController?
    var dataStore: AppStorageOrderManagerProtocol?
    var tabBarAnimator: TabBarAnimator?
    var tabSelectionPublisher = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let tabBarBackgroundColor = UIColor(Color.backgroundTabBar)
    private var headView: UIView?
    var customTabBarItem: CustomTabBarItem?

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeadView()
        setupTabBar()
        setupTabBarAppearance()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarHeight()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeadView()
        updateCartBnt()
        if tabBarAnimator == nil {
            setupTabBarAnimator()
        }
        
        tabBarAnimator?.setupGradientOverlay()
        handleTabSelection(index: selectedIndex)
    }
    
    func setupTabBarAnimator() {
        tabBarAnimator = TabBarAnimator(tabBar: tabBar)
    }
}

// MARK: - TabBar Setup

private extension TabBarController {
    
    func setupTabBar() {
        addCustomTabBarItem()
        updateTabBarHeight()
        handleTabSelection(index: selectedIndex)
    }
    
    func addCustomTabBarItem() {
        customTabBarItem = CustomTabBarItem(
            frame: CGRect(x: 0, y: view.frame.height, width: self.view.frame.width, height: 56)
        )
        
        if let customTabBarItem = customTabBarItem {
            self.view.addSubview(customTabBarItem)
            view.layoutIfNeeded()
            
            customTabBarItem.tabSelectionPublisher
                .sink { [weak self] selectedIndex in
                    self?.handleTabSelection(index: selectedIndex)
                }
                .store(in: &cancellables)
        }

    }
    
    func updateCartBnt() {
        if let dataStore = dataStore as? AppStorageOrderManager {
            dataStore.ordersPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] orders in
                    self?.updateCartButton(with: orders)
                }
                .store(in: &cancellables)
        }
    }
    
    func handleTabSelection(index: Int) {
        selectedIndex = index
        tabBarAnimator?.updateSelectionLayerPosition(animated: true, selectedIndex: index)
    }
    
    func updateTabBarHeight() {
        guard let customTabBarItem = customTabBarItem else { return }
        
        // Ajusta a altura da tabBar levando em consideração a safe area
        let safeAreaBottomInset = view.safeAreaInsets.bottom
        customTabBarItem.frame.origin.y = view.frame.height - customTabBarItem.frame.height - safeAreaBottomInset
    }
    
    func updateCartButton(with orders: [Order]) {
        guard let customTabBarItem = customTabBarItem else { return }
        let totalQuantity = orders.reduce(0) { $0 + $1.quantity }
        customTabBarItem.button2?.setTitle("Carrinho (\(totalQuantity))", for: .normal)
    }

}

// MARK: - TabBar Appearance Setup

private extension TabBarController {
    
    func setupTabBarAppearance() {
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
    
    func configureTabBarItemAppearance(_ appearance: UITabBarAppearance) {
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
    }
}

// MARK: - Head View Setup

private extension TabBarController {
    
    func setupHeadView() {
        let headHeight: CGFloat = 20 + view.safeAreaInsets.top
        
        headView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headHeight))
        headView?.backgroundColor = UIColor(Color.backgroundTabBar)
        
        let titleLabel = UILabel()
        titleLabel.text = "WeMovies"
        titleLabel.font = UIFont.openSansBold(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headView?.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headView!.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headView!.centerYAnchor, constant: view.safeAreaInsets.top - headHeight * 0.6 )
        ])
        
        if let headView = headView {
            view.addSubview(headView)
        }
        view.layoutIfNeeded()
    }
}

