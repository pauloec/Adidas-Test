//
//  ReviewRequest.swift
//  APILayer
//
//  Created by Paulo Correa on 2/11/2564 BE.
//

public class ReviewRequest: APIRequest {
    public var method = RequestType.GET
    public var path = "reviews"
    public var parameters = [String: String]()
    public var version: APIVersion = .V2

    public init() { }
}

public struct ReviewModel: Codable {
    public let productId: String
    public let locale: String
    public let rating: Double
    public let text: String
}
