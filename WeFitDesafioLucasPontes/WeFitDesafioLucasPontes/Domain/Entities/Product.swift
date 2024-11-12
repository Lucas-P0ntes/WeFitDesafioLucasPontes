//
//  Product.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//


import Foundation

struct products: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let image: String
    
    init(id: Int, title: String, price: Double, image: String) {
        self.id = id
        self.title = title
        self.price = price
        self.image = image
    }

    static func == (lhs: products, rhs: products) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.price == rhs.price &&
               lhs.image == rhs.image
    }
}
