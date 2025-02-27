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
    
    func configure(with product: ProductList) {
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
    }
}
