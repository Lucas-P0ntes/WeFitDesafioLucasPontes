//
//  TabBarAppearanceConfigurator.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit

class TabBarAppearanceConfigurator {
    
    static func setupTabBarAppearance(for tabBar: UITabBar, with backgroundColor: UIColor) {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
        tabBar.barTintColor = backgroundColor
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        configureTabBarItemAppearance(appearance)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private static func configureTabBarItemAppearance(_ appearance: UITabBarAppearance) {
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
    }
}
