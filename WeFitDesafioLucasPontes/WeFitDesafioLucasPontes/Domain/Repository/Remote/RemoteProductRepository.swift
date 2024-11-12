//
//  RemoteProductRepository.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import Foundation

class RemoteProductRepository: ProductRepository {
    private let url = URL(string: "https://wefit-movies.vercel.app/api/movies")!

    func fetchProducts(completion: @escaping (Result<[products], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedProducts = try JSONDecoder().decode([String: [products]].self, from: data)
                if let products = decodedProducts["products"] {
                    completion(.success(products))
                } else {
                    completion(.failure(NSError(domain: "DecodingError", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
