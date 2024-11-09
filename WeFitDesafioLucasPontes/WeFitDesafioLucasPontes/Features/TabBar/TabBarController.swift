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
        
        // Substituindo o UIViewController vazio por um controlador de view relevante, caso necessário
        let thirdViewController = UIViewController() // Ou outro controlador adequado
        
        // Configurando os View Controllers da Tab Bar
        viewControllers = [cartHostingController, homeHostingController, thirdViewController]
        
        // Criando e configurando o CustomTabBar
        let customTabBar = CustomTabBar(frame: CGRect(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50))
        self.view.addSubview(customTabBar)
        
        // Observando notificações de mudança de aba (considerar alternativas mais simples)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToFirst), name: NSNotification.Name("SwitchToFirst"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToSecond), name: NSNotification.Name("SwitchToSecond"), object: nil)
    }
    
    // Funções para mudar para o primeiro e segundo view controller
    @objc private func switchToFirst() {
        selectedIndex = 0
        updateSelectionLayerPosition(animated: true, selectedIndex: 0)
    }
    
    @objc private func switchToSecond() {
        selectedIndex = 1
        updateSelectionLayerPosition(animated: true, selectedIndex: 1)
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

    private func updateSelectionLayerPosition(animated: Bool, selectedIndex: Int) {
        
        // Calcule a posição X baseada no índice selecionado
        let indicatorPositionX = (tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)) * CGFloat(selectedIndex)
        
        // Função de atualização das posições
        let updateFrames = {
            self.selectionLayer.frame.origin.x = indicatorPositionX
            self.gradientLayer.frame.origin.x = indicatorPositionX
        }
        
        // Se animado, aplicar a animação de transição
        if animated {
            UIView.animate(withDuration: 0.3, animations: updateFrames)
        } else {
            updateFrames()
        }
    }

}
