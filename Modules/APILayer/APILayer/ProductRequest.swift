//
//  ProductListEndpoint.swift
//  APILayer
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

public class ProductListRequest: APIRequest {
    public var method = RequestType.GET
    public var path = "product"
    public var parameters = [String: Any]()
    public var version: APIVersion = .V1

    public init() { }
}

public class ProductDetailRequest: APIRequest {
    public var method = RequestType.GET
    public var path = "product"
    public var parameters = [String: Any]()
    public var version: APIVersion = .V1

    public init(id: String) {
        path = path + "/\(id)"
    }
}

public struct ProductModel: Codable {
    public let id: String
    public let name: String
    public let description: String
    public let currency: String
    public let price: Double
    public let imgUrl: String
}
