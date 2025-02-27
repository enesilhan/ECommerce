//
//  ProductDetailViewModel.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

class ProductDetailViewModel {
    
    private let productDetailService: ProductDetailServiceProtocol
    private var productDetail: ProductDetailModel?
    
    var onDataUpdated: ((ProductDetailModel) -> Void)?
    var onError: ((String) -> Void)?
    
    init(productDetailService: ProductDetailServiceProtocol = ProductDetailService()) {
        self.productDetailService = productDetailService
    }
    
    func fetchProductDetail(productId: Int) {
        productDetailService.fetchProductDetail(productId: productId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let productDetail):
                self.productDetail = productDetail
                self.onDataUpdated?(productDetail)
                
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func getProductDetail() -> ProductDetailModel? {
        return productDetail
    }
}
