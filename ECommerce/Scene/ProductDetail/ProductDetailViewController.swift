//
//  ProductDetailViewController.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var brandNameLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var favoriteButton: UIButton!

    private let viewModel = ProductDetailViewModel()
    var productId: Int?
    var onFavoriteUpdated: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProductDetails()
        updateFavoriteButton()
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
        if let imageUrl = product.result.images.first?.images.first?.imageURL, let url = URL(string: imageUrl) {
            self.imageView.kf.setImage(
                with: url,options: [
                    .transition(.fade(0.3))
                ]
            )
        }

        let description = product.result.description
            let fullDescription = """
            Özellikler: \(description.özellikler)<br/>
            Yıl Sezon: \(description.yılSezon)<br/>
            Kumaş ve Bakım: \(description.kumaşVeBakım)
            """
        descriptionTextView.attributedText = fullDescription.toHTMLAttributedString()
    
        self.brandNameLabel.text = product.result.brandName
        self.productNameLabel.text = product.result.displayName
        self.productPriceLabel.text = product.result.actualPriceText
    }

    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let productId = productId else { return }
        FavoritesManager.shared.toggleFavorite(productId: productId)
        updateFavoriteButton()

        onFavoriteUpdated?()
    }

    private func updateFavoriteButton() {
        guard let productId = productId else { return }
        let isFav = FavoritesManager.shared.isFavorite(productId: productId)
        let imageName = isFav ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
