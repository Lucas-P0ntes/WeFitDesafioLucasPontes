//
//  Order.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 10/11/24.
//

import SwiftUI

struct Order: Identifiable, Codable {
    var id: UUID
    var products: products
    var quantity: Int
}
