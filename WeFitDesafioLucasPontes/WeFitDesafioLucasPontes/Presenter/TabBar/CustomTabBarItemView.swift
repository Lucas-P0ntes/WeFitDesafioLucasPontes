//
//  CustomTabBarItemView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit
import Combine
import SwiftUI

class CustomTabBarItem: UIView {

    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    
    private var selectionLayer = CALayer()
    
    var tabSelectionPublisher = PassthroughSubject<Int, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        animateSelectionLayer(to: 1)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        
    }

    private func setupButtons() {
        // Configurações de botões
        button1 = createButton(
            title: "Home",
            image: ImageAssets.IconBarHome,
            action: #selector(button2Tapped),
            xPosition: frame.width / 3
        )
        
        button2 = createButton(
            title: "Carrinho",
            image: ImageAssets.IconBarCart,
            action: #selector(button1Tapped),
            xPosition: 0
        )
    
        button3 = createButton(
            title: "Perfil",
            image: ImageAssets.iconBarUser,
            action: #selector(button3Tapped),
            xPosition: 2 * frame.width / 3,
            isEnabled: false
        )
    }
    
    private func createButton(title: String, image: UIImage?, action: Selector, xPosition: CGFloat, isEnabled: Bool = true) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        // Set button frame based on xPosition and parent frame dimensions
        button.frame = CGRect(x: xPosition, y: 0, width: frame.width / 3, height: frame.height)
        
        // Customize appearance
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.openSansRegular(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.isEnabled = isEnabled
        
        // Add padding between image and title
        let padding: CGFloat = 4
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: padding)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: -padding)
        
        addSubview(button)
        return button
    }

    @objc private func button1Tapped() {
        animateSelectionLayer(to: 0)
        tabSelectionPublisher.send(0)
    }

    @objc private func button2Tapped() {
        animateSelectionLayer(to: 1)
        tabSelectionPublisher.send(1)
    }

    @objc private func button3Tapped() {}

     func animateSelectionLayer(to index: Int) {
        [button1, button2].forEach { button in
            button?.tintColor = index == [button1, button2].firstIndex(of: button) ?  .gray : UIColor(Color.textlight)
            button?.setTitleColor(index == [button1, button2].firstIndex(of: button) ? .gray : UIColor(Color.textlight), for: .normal)

        }
    }
}

