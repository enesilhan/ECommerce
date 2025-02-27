//
//  ProductDetailViewController.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    private let viewModel = ProductDetailViewModel()
    var productId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProductDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func fetchProductDetails() {
        guard let productId = productId else { return }
        viewModel.fetchProductDetail(productId: productId)
        
        viewModel.onDataUpdated = { [weak self] productDetail in
            DispatchQueue.main.async {
                self?.updateUI(with: productDetail)
            }
        }
        
        viewModel.onError = { error in
        }
    }
    
    private func updateUI(with product: ProductDetailModel) {
    }
}
