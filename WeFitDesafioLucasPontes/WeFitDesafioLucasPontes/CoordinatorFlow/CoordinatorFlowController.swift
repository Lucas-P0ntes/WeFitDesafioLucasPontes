//
//  CoordinatorFlowController.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation
import UIKit

class CoordinatorFlowController {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController? {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        navigationController.pushViewController(tabBarController, animated: false)
        return tabBarController
    }
}
