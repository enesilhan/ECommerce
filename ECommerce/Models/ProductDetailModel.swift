//
//  ProductDetailModel.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

struct ProductDetailModel: Codable {
    var result: DetailResult

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

struct DetailResult: Codable {
    var displayName: String
    var description: Description
    var brandName: String
    var actualPriceText: String
    var images: [ResultImage]
    
    enum CodingKeys: String, CodingKey {
        case displayName = "DisplayName"
        case description = "Description"
        case brandName = "BrandName"
        case actualPriceText = "ActualPriceText"
        case images = "Images"
    }
}

struct Description: Codable {
    var özellikler, yılSezon, kumaşVeBakım: String

    enum CodingKeys: String, CodingKey {
        case özellikler = "Özellikler :"
        case yılSezon = "Yıl Sezon :"
        case kumaşVeBakım = "Kumaş ve Bakım :"
    }
}

struct ResultImage: Codable {
    var displayOrder: Int
    var images: [ImageImage]

    enum CodingKeys: String, CodingKey {
        case displayOrder = "DisplayOrder"
        case images = "Images"
    }
}

struct ImageImage: Codable {
    var imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "ImageUrl"
    }
}
