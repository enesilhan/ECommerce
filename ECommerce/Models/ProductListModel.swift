//
//  ProductListModel.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

struct ProductListModel: Codable {
    var result: ResultModel?

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

struct ResultModel: Codable {
    var productList: [ProductList]?
    var totalPageCount: Int?
    var shareLink: String?

    enum CodingKeys: String, CodingKey {
        case productList = "ProductList"
        case totalPageCount = "TotalPageCount"
        case shareLink = "ShareLink"
    }
}

struct ProductList: Codable {
    var productID: Int?
    var displayName: String?
    var brandName: String?
    var imageURL: String?
    var imageUrls: [String]
    var strikeThroughPriceToShowOnScreenText: String?
    var actualPriceToShowOnScreenText: String?
    var discountRate: Int?
    var price: Int?
    var newDiscountRateText: String?
    var isOutOfStock: Bool?
    var color: String?

    enum CodingKeys: String, CodingKey {
        case productID = "ProductId"
        case displayName = "DisplayName"
        case brandName = "BrandName"
        case imageURL = "ImageUrl"
        case imageUrls = "ImageUrls"
        case strikeThroughPriceToShowOnScreenText = "StrikeThroughPriceToShowOnScreenText"
        case actualPriceToShowOnScreenText = "ActualPriceToShowOnScreenText"
        case discountRate = "DiscountRate"
        case price = "Price"
        case newDiscountRateText = "NewDiscountRateText"
        case isOutOfStock = "IsOutOfStock"
        case color = "Color"
    }
}
