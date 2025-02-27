//
//  FavoritesManager.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favorite_products"
    private var favoritesUpdated: (() -> Void)?
    
    private init() {}
    
    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func isFavorite(productId: Int) -> Bool {
        return getFavorites().contains(productId)
    }
    
    func toggleFavorite(productId: Int) {
        var favorites = getFavorites()
        
        if favorites.contains(productId) {
            favorites.removeAll { $0 == productId }
        } else {
            favorites.append(productId)
        }
        
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
        UserDefaults.standard.synchronize()
        
        favoritesUpdated?()
    }
    
    func setFavoritesUpdatedCallback(_ callback: @escaping () -> Void) {
        self.favoritesUpdated = callback
    }
}
