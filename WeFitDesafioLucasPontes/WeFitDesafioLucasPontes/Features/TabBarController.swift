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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        var homeView = HomeView(viewModel: HomeViewModel())
        homeView.coordinator = coordinator
        let hostingController = UIHostingController(rootView: homeView)
        hostingController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        
        var cartView = CartView(viewModel: CartViewModel())
        cartView.coordinator = coordinator
        let CarthostingController = UIHostingController(rootView: cartView)
        CarthostingController.tabBarItem = UITabBarItem(title: "Cart", image: nil, selectedImage: nil)
        

        
        viewControllers = [ hostingController, CarthostingController]
        
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
}
