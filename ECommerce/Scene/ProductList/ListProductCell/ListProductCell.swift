//
//  ListProductCell.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import UIKit
import Kingfisher

class ListProductCell: UICollectionViewCell {
    static let reuseIdentifier = "ListProductCell"
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private var productId: Int?
    
    func configure(with product: ProductList) {
        productId = product.productID
        productNameLabel.text = product.displayName ?? ""
        productPriceLabel.text = product.actualPriceToShowOnScreenText ?? ""
        
        if let imageUrl = product.imageURL, let url = URL(string: imageUrl) {
            productImageView.kf.setImage(
                with: url,options: [
                    .transition(.fade(0.3))
                ]
            )
        }
        self.layer.cornerRadius = 15
        updateFavoriteButton()
    }

    @IBAction func favoriteAction(_ sender: Any) {
        guard let productId = productId else { return }
        FavoritesManager.shared.toggleFavorite(productId: productId)
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        guard let productId = productId else { return }
        let isFav = FavoritesManager.shared.isFavorite(productId: productId)
        let imageName = isFav ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
