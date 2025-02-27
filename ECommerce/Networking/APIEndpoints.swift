//
//  APIEndpoints.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

struct APIEndpoints {
    
    private static let baseURL = "https://www.beymen.com/Mobile2/api/mbproduct"
    
    static func productList(page: Int) -> String {
        return "\(baseURL)/list?siralama=akillisiralama&sayfa=\(page)&categoryId=10020&includeDocuments=true"
    }
    
    static func productDetail(productId: Int) -> String {
        return "\(baseURL)/product?productid=\(productId)"
    }
}
