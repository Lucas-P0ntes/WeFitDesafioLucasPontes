//
//  ProductRepository.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation

protocol ProductRepository {
    func fetchProducts(completion: @escaping (Result<[products], Error>) -> Void)
}
