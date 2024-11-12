//
//  CoordinatorFlowController.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

class CoordinatorFlowController {
    
    private var navigationController: UINavigationController
    private var tabBarController: TabBarController?
    private var appStorageOrderManager = AppStorageOrderManager()
    private var loadingViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSplashScreen()
    }
    
    private func showSplashScreen() {
        let splashScreen = SplashScreenView { [weak self] in  self?.showTabBarController() }
        let splashHostingController = UIHostingController(rootView: splashScreen)
        splashHostingController.safeAreaRegions = []
        navigationController.setViewControllers([splashHostingController], animated: false)
    }
    
    func showLoadView() {
        let loadView = LoadingView()
        let loadHostingController = UIHostingController(rootView: loadView)
        loadHostingController.safeAreaRegions = []
        loadHostingController.modalPresentationStyle = .overFullScreen
        navigationController.present(loadHostingController, animated: false)
        
        loadData { [weak self] in
            self?.showTabBarController()
            self?.dismissLoadingView()
        }
        
        self.loadingViewController = loadHostingController
    }
    
    private func dismissLoadingView() {
        loadingViewController?.dismiss(animated: true)
        loadingViewController = nil
    }
    
    func showTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        tabBarController.dataStore = appStorageOrderManager
        
        let homeViewController = createHomeView()
        let cartViewController = createCartView()
        let thirdViewController = createThirdViewController()
        
        tabBarController.viewControllers = [cartViewController, homeViewController, thirdViewController]
        tabBarController.selectedIndex = 1
        navigationController.setViewControllers([tabBarController], animated: true)
        
        self.tabBarController = tabBarController
        showLoadOverlay() // Exibe a tela de carregamento sobre a tab bar
        
        loadData { [weak self] in
            self?.removeLoadOverlay() // Remove a tela de carregamento quando o carregamento for concluído
        }
    }

    private func showLoadOverlay() {
        let loadView = LoadingView()
        let loadHostingController = UIHostingController(rootView: loadView)
        loadHostingController.modalPresentationStyle = .overFullScreen
        tabBarController?.present(loadHostingController, animated: false, completion: nil)
    }

    private func removeLoadOverlay() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }

    func navigateToSecondTab(_ index: Int) {
        tabBarController?.selectedIndex = index
        tabBarController?.tabBarAnimator?.updateSelectionLayerPosition(animated: true, selectedIndex: index)
        tabBarController?.customTabBarItem?.animateSelectionLayer(to: index)
    }
    
    private func loadData(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func createHomeView() -> UIViewController {
        let homeViewModel = HomeViewModel(
            getProductsUseCase: GetProductsUseCaseImpl(repository: RemoteProductRepository()),
            dataStore: appStorageOrderManager,
            coordinator: self
        )
        let homeView = HomeView(viewModel: homeViewModel)
        return UIHostingController(rootView: homeView)
    }

    private func createCartView() -> UIViewController {
        let cartViewModel = CartViewModel(
            getProductsUseCase: GetProductsUseCaseImpl(repository: RemoteProductRepository()),
            dataStore: appStorageOrderManager,
            coordinator: self
        )
        let cartView = CartView(viewModel: cartViewModel)
        return UIHostingController(rootView: cartView)
    }
    
    private func createThirdViewController() -> UIViewController {
        return UIViewController()
    }
}
