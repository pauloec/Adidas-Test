//
//  ProductListEndpoint.swift
//  APILayer
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

class ProductListRequest: APIRequest {
    var method = RequestType.GET
    var path = "product"
    var parameters = [String: String]()
}

struct ProductListModel: Codable {
    let id: String
    let name: String
    let description: String
    let currencty: String
    let price: Double
    let imgUrl: String
}
