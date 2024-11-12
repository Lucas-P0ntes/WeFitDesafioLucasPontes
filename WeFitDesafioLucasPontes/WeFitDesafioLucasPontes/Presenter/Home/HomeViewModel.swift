//
//  HomeViewModel.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var orderItems: [Order] = []
    
    private let dataStore: AppStorageOrderManagerProtocol
    private let coordinator: CoordinatorFlowController
    private let getProductsUseCase: GetProductsUseCase
    
    // Combine Subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    init(getProductsUseCase: GetProductsUseCase, dataStore: AppStorageOrderManagerProtocol, coordinator: CoordinatorFlowController) {
        self.getProductsUseCase = getProductsUseCase
        self.dataStore = dataStore
        self.coordinator = coordinator
        
        observeOrderUpdates()
        fetchProducts()
    }
    
    func appearAction() {
        fetchProducts()
    }
    
    func addToCart(product: products, quantity: Int) {
        dataStore.addOrder(product, quantity)
    }
    
    func getQuantityInCart(for product: products) -> Int {
        return orderItems.first(where: { $0.products.id == product.id })?.quantity ?? 0
    }
    
    func loadAllOrders() {
        orderItems = dataStore.getAllOrders() 
    }
    
    // MARK: - Private Methods
    private func fetchProducts() {
        isLoading = true
        getProductsUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.syncOrdersWithProducts(products)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func syncOrdersWithProducts(_ products: [products]) {
        let currentProductIDs = orderItems.map { $0.products.id }
        let newProducts = products.filter { !currentProductIDs.contains($0.id) }
        
        for product in newProducts {
            dataStore.addOrder(product, 0)
        }
    }
    
     func observeOrderUpdates() {
        if let dataStore = dataStore as? AppStorageOrderManager {
            dataStore.ordersPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] orders in
                    self?.orderItems = orders
                }
                .store(in: &cancellables)
        }
    }
}
