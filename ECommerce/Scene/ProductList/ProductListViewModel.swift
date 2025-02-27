//
//  ProductListViewModel.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

class ProductListViewModel {
    
    private let productService: ProductListServiceProtocol
    private var products: [ProductList] = []
    private var shareLink: String?
    
    private var currentPage = 1
    private var totalPageCount = 1
    private var isLoading = false
    
    var onDataUpdated: (([ProductList]) -> Void)?
    var onError: ((String) -> Void)?
    
    init(productService: ProductListServiceProtocol = ProductListService()) {
        self.productService = productService
    }
    
    func fetchProducts() {
        guard !isLoading, currentPage <= totalPageCount else { return }
        isLoading = true
        
        productService.fetchProducts(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                if let newProducts = response.result?.productList {
                    self.products.append(contentsOf: newProducts)
                    self.currentPage += 1
                    self.totalPageCount = response.result?.totalPageCount ?? self.totalPageCount
                    self.shareLink = response.result?.shareLink
                    self.onDataUpdated?(self.products)
                }
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func getProducts() -> [ProductList] {
        return products
    }

    func getShareLink() -> String? {
        return shareLink
    }
}
