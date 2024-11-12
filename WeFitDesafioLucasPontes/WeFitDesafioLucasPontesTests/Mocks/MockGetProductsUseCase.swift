//
//  MockGetProductsUseCase.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 11/11/24.
//


import XCTest
@testable import WeFitDesafioLucasPontes
// Mock para o GetProductsUseCase
class MockGetProductsUseCase: GetProductsUseCase {
    var result: Result<[products], Error> = .success([])

    func execute(completion: @escaping (Result<[products], Error>) -> Void) {
        completion(result)
    }
}
