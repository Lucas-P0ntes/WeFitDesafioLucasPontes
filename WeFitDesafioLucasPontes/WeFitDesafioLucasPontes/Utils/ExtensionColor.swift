//
//  ExtesionColor.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation
import SwiftUI

extension Color {
    // Background Colors
    static let backgroundPrimary = Color(hex: "#2F2E41")
    static let backgroundTabBar = Color(hex: "#1D1D2B")

    // Text Colors
    static let textlight = Color(hex: "#FFFFFF")
    static let textDark = Color(hex: "#333333")
    static let textGray = Color(hex: "#A1A1A1")
    static let textCustom = Color(hex: "#2F2E41")

    // Accent Colors
    static let ButtonPrimary = Color(hex: "#009EDD")
    static let ButtonPrimarySelected = Color(hex: "#039B00")
    static let ButtonPrimaryaddCart = Color(hex: "#039B00")
    
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
