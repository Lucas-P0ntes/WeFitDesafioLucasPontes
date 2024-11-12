//
//  TabBarAnimator.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit

class TabBarAnimator {
    private var selectionLayer: CALayer
    private var gradientLayer: CAGradientLayer
    private var tabBar: UITabBar
    private let indicatorHeight: CGFloat = 3.0
    private let gradientHeight: CGFloat = 50.0
    
    init(tabBar: UITabBar) {
        // Inicializa os layers
        self.selectionLayer = CALayer()
        self.gradientLayer = CAGradientLayer()
        
        self.tabBar = tabBar
    }

    func setupGradientOverlay() {
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1), height: gradientHeight)
        
        selectionLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1), height: indicatorHeight)
        selectionLayer.backgroundColor = UIColor.white.cgColor
        
        tabBar.layer.addSublayer(selectionLayer)
        tabBar.layer.addSublayer(gradientLayer)
    }

    func updateSelectionLayerPosition(animated: Bool, selectedIndex: Int) {
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
