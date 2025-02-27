//
//  ProductDetailService.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func fetchProductDetail(productId: Int, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> Void)
}

class ProductDetailService: ProductDetailServiceProtocol {
    
    func fetchProductDetail(productId: Int, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> Void) {
        let urlString = APIEndpoints.productDetail(productId: productId)
        NetworkManager.shared.fetchData(from: urlString, completion: completion)
    }
}
