//
//  SceneDelegate.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

        var window: UIWindow?

        var coordinator: CoordinatorFlowController?
        
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = scene as? UIWindowScene else { return }
            
            let window = UIWindow (windowScene: windowScene)
            
            coordinator = CoordinatorFlowController(navigationController: UINavigationController())
            let rootViewController = coordinator?.start()
            
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()

            self.window = window
        }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

