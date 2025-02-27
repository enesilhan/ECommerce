//
//  ProductListService.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

protocol ProductListServiceProtocol {
    func fetchProducts(page: Int, completion: @escaping (Result<ProductListModel, NetworkError>) -> Void)
}

class ProductListService: ProductListServiceProtocol {
    
    func fetchProducts(page: Int, completion: @escaping (Result<ProductListModel, NetworkError>) -> Void) {
        let urlString = APIEndpoints.productList(page: page)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ProductListModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
