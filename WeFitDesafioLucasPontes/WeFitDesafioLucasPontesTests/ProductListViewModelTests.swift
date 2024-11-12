//
//  ProductListViewModelTests.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 11/11/24.
//

import XCTest
import Combine
@testable import WeFitDesafioLucasPontes

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockGetProductsUseCase: MockGetProductsUseCase!
    var mockDataStore: MockAppStorageOrderManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockGetProductsUseCase = MockGetProductsUseCase()
        mockDataStore = MockAppStorageOrderManager()
        viewModel = HomeViewModel(getProductsUseCase: mockGetProductsUseCase, dataStore: mockDataStore, coordinator: CoordinatorFlowController(navigationController: UINavigationController()))
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockGetProductsUseCase = nil
        mockDataStore = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        // Configura o mock para retornar produtos simulados
        let expectedProducts = [
            products(id: 1, title: "Viúva Negra", price: 9.99, image: "https://example.com/viuva-negra.png")
        ]
        mockGetProductsUseCase.result = .success(expectedProducts)

        let expectation = self.expectation(description: "Products loaded")
        
        // Garantir atualização na main thread
        DispatchQueue.main.async {
            self.viewModel.$products
                .dropFirst()
                .sink { products in
                    XCTAssertEqual(products, expectedProducts, "Expected products to be loaded")
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
            
            self.viewModel.appearAction()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchProductsFailure() {
        // Configura o mock para retornar um erro
        mockGetProductsUseCase.result = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))

        let expectation = self.expectation(description: "Error message set")
        
        // Garantir atualização na main thread
        DispatchQueue.main.async {
            self.viewModel.$errorMessage
                .dropFirst()
                .sink { errorMessage in
                    XCTAssertNotNil(errorMessage, "Expected an error message on failure")
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
            
            self.viewModel.appearAction()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testAddToCart() {
        let product = products(id: 1, title: "Viúva Negra", price: 9.99, image: "https://example.com/viuva-negra.png")

        viewModel.addToCart(product: product, quantity: 2)

        XCTAssertEqual(mockDataStore.orders.count, 1, "Expected one order in the data store")
        XCTAssertEqual(mockDataStore.orders.first?.quantity, 2, "Expected quantity to be 2")
    }
}
