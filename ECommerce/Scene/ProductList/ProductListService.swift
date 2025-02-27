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
        NetworkManager.shared.fetchData(from: urlString, completion: completion)
    }
}
