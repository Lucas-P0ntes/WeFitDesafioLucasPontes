//
//  MockAppStorageOrderManager.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 11/11/24.
//

import XCTest
import Combine
@testable import WeFitDesafioLucasPontes

class MockAppStorageOrderManager: AppStorageOrderManagerProtocol {
    func getAllOrders() -> [WeFitDesafioLucasPontes.Order] {
        return []
    }
    
    func updateOrder(idProduct: Int, product: WeFitDesafioLucasPontes.products, _ quantity: Int?) {
        
    }
    
    func removeOrder(_ product: WeFitDesafioLucasPontes.products) {
        
    }
    
    var ordersPublisher = PassthroughSubject<[Order], Never>()
    private(set) var orders: [Order] = []

    func addOrder(_ product: products, _ quantity: Int) {
        let order = Order(id: UUID(), products: product, quantity: quantity)
        orders.append(order)
        ordersPublisher.send(orders)
    }
}
