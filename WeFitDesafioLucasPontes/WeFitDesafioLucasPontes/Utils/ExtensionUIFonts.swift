//
//  ExtensionUIFonts.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 10/11/24.
//

import SwiftUI
import UIKit


extension UIFont {
    static func openSansBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size) ?? UIFont.systemFont(ofSize: 80, weight: .bold)
    }
    
    static func openSansRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: 80, weight: .regular)
    }
}

extension Font {
    static func openSansBold(size: CGFloat) -> Font {
        return Font(UIFont.openSansBold(ofSize: size))
    }
    
    static func openSansRegular(size: CGFloat) -> Font {
        return Font(UIFont.openSansRegular(ofSize: size))
    }
}


