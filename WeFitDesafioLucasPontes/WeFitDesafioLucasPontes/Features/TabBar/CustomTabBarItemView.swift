//
//  CustomTabBarItemView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit

class CustomTabBarItemView: UIView {
    
    private let imageView: UIImageView
    private let titleLabel: UILabel
    
    init(title: String, imageName: String) {
        // Create image view
        imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 24, height: 24)
        
        // Create title label
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        super.init(frame: .zero)
        
        // Create StackView to contain both image and label
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.frame.size = CGSize(width: 100, height: 50)  // Adjust size as necessary
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
