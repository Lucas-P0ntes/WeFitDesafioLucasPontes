//
//  AppStorageQuestionManager.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 10/11/24.
//

import SwiftUI
import Combine

class AppStorageOrderManager: AppStorageOrderManagerProtocol {
    @AppStorage("order") private var orderData: Data = Data()
    
    // Use PassthroughSubject to notify changes
    private var ordersSubject = PassthroughSubject<[Order], Never>()
    
    private var allOrder: [Order] {
        get {
            guard let decodedOrders = try? JSONDecoder().decode([Order].self, from: orderData) else {
                return []
            }
            return decodedOrders
        }
        set {
            guard let encodedOrders = try? JSONEncoder().encode(newValue) else {
                return
            }
            orderData = encodedOrders
            ordersSubject.send(newValue)
        }
    }
    
    // Combine publisher to listen for updates
    var ordersPublisher: AnyPublisher<[Order], Never> {
        return ordersSubject.eraseToAnyPublisher()
    }
    
    func updateOrder(idProduct: Int, product: products, _ quantity: Int?) {
        if let index = allOrder.firstIndex(where: { $0.products.id == idProduct }) {
            allOrder[index].products = product
            if let quantity, allOrder[index].quantity + quantity >= 1 {
                allOrder[index].quantity += quantity
            }
        }
    }
    
    func addOrder(_ product: products, _ quantity: Int) {
        if let index = allOrder.firstIndex(where: { $0.products.id == product.id }) {
            updateOrder(idProduct: product.id, product: product, quantity)
        } else {
            let newOrder = Order(id: UUID(), products: product, quantity: quantity)
            allOrder.append(newOrder)
        }
    }
    
    func getAllOrders() -> [Order] {
        return allOrder.filter { $0.quantity >= 1 }
    }
    
    func removeOrder(_ product: products) {
        if let index = allOrder.firstIndex(where: { $0.products.id == product.id }) {
            var newOrderList = allOrder
            newOrderList.remove(at: index)
            self.allOrder = newOrderList
        }
    }
    
    func endOrders() {
        allOrder = []
    }
}
