//
//  GetProductsUseCaseImpl.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation

class GetProductsUseCaseImpl: GetProductsUseCase {
    private let repository: ProductRepository

    init(repository: ProductRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[products], Error>) -> Void) {
        repository.fetchProducts { result in
            completion(result)
        }
    }
}
