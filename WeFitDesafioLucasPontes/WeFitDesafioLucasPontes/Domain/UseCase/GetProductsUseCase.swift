//
//  GetProductsUseCase.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation

protocol GetProductsUseCase {
    func execute(completion: @escaping (Result<[products], Error>) -> Void)
}
