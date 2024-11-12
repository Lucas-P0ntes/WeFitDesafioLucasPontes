//
//  ImageAssets.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import UIKit
import SwiftUI

public struct ImageAssets {
    public static var IconBarCart: UIImage? { return "cart".asUIImage }
    public static var IconBarHome: UIImage? { return "home".asUIImage }
    public static var iconBarUser: UIImage? { return "user".asUIImage }
    public static var iconCartAdd: UIImage? { return "cartAdd".asUIImage }
    
    public static var icontrash: UIImage? { return "trash".asUIImage }
    public static var iconMore: UIImage? { return "mais".asUIImage }
    public static var iconless: UIImage? { return "menos".asUIImage }
    
    public static var imgPersonReload: UIImage? { return "personReload".asUIImage }
    public static var imgPersonBackHome: UIImage? { return "personBackHome".asUIImage }
    public static var imgPersonAllRight: UIImage? { return "personAllRight".asUIImage }
}

// MARK: - UIImage Extension

private extension UIImage {
    convenience init?(pdf: String) {
        self.init(named: pdf, in: nil, with: nil)
    }
}

private extension String {
    var asUIImage: UIImage? {
        return UIImage(pdf: self)
    }
}

private extension UIImage {
    var asSwiftUIImage: Image {
        Image(uiImage: self)
    }
}

