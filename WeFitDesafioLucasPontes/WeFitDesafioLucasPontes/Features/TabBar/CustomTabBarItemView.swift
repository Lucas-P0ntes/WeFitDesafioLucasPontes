//
//  CustomTabBarItemView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit

class CustomTabBar: UIView {

    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    
    private var selectionLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
       // setupGradientOverlay()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    private func setupButtons() {
        // Botão 1
        button1 = UIButton(type: .system)
        button1.setTitle("First", for: .normal)
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button1.frame = CGRect(x: 0, y: 0, width: frame.width / 3, height: frame.height)
        addSubview(button1)

        // Botão 2
        button2 = UIButton(type: .system)
        button2.setTitle("Second", for: .normal)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button2.frame = CGRect(x: frame.width / 3, y: 0, width: frame.width / 3, height: frame.height)
        addSubview(button2)
        
        // Botão 3
        button3 = UIButton(type: .system)
        button3.setTitle("Third", for: .normal)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button3.frame = CGRect(x: 2 * frame.width / 3, y: 0, width: frame.width / 3, height: frame.height)
        addSubview(button3)
        
    }

    @objc private func button1Tapped() {
        animateSelectionLayer(to: 0)
        NotificationCenter.default.post(name: NSNotification.Name("SwitchToFirst"), object: nil)
    }

    @objc private func button2Tapped() {
        animateSelectionLayer(to: 1)
        NotificationCenter.default.post(name: NSNotification.Name("SwitchToSecond"), object: nil)
    }

    @objc private func button3Tapped() {
        animateSelectionLayer(to: 2)
        // Ação para o botão 3
    }

    // Função para animar a transição da camada de seleção
    private func animateSelectionLayer(to index: Int) {
        
        // Também pode animar a mudança de cor do botão ou outro efeito, se necessário
        [button1, button2, button3].forEach { button in
            button?.setTitleColor(index == [button1, button2, button3].firstIndex(of: button) ? .white : .gray, for: .normal)
        }
    }
}


