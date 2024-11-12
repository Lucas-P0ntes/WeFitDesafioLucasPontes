//
//  CartViewModel.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    @Published var totalAmount: Double = 0.0
    @Published var orderItems: [Order] = [] {
        didSet {
            calculateTotalAmount()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let dataStore: AppStorageOrderManagerProtocol
    private let coordinator: CoordinatorFlowController
    private let getProductsUseCase: GetProductsUseCase
    
    init(getProductsUseCase: GetProductsUseCase, dataStore: AppStorageOrderManagerProtocol, coordinator: CoordinatorFlowController) {
        self.getProductsUseCase = getProductsUseCase
        self.dataStore = dataStore
        self.coordinator = coordinator
        
        observeOrderUpdates()
        loadCartItems()
    }
    
    func loadCartItems() {
        orderItems = dataStore.getAllOrders().filter { $0.quantity >= 1 }
    }
    
    func navigateToSecondTab() {
        coordinator.navigateToSecondTab(1)
    }
    
    private func calculateTotalAmount() {
        totalAmount = orderItems.reduce(0) { result, order in
            result + (Double(order.quantity) * order.products.price)
        }
    }
    
    func addToCart(product: products) {
        dataStore.addOrder(product, 1)
    }
    
    func removeFromCart(product: products) {
        dataStore.updateOrder(idProduct: product.id, product: product, -1)
    }
    
    func removeOrder(product: products) {
        dataStore.removeOrder(product)
    }
    
    func endOrder() {
        dataStore.endOrders()
    }
    
    private func observeOrderUpdates() {
        if let dataStore = dataStore as? AppStorageOrderManager {
            dataStore.ordersPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] orders in
                    let ordersItens = orders.filter { $0.quantity >= 1 }
                    self?.orderItems = ordersItens
                }
                .store(in: &cancellables)
        }
    }
}
