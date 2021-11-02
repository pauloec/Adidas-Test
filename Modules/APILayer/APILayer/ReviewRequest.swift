//
//  ReviewRequest.swift
//  APILayer
//
//  Created by Paulo Correa on 2/11/2564 BE.
//

public class AddReviewRequest: APIRequest {
    public var method = RequestType.POST
    public var path = "reviews"
    public var parameters = [String: String]()
    public var version: APIVersion = .V2

    public init(review: ReviewModel) {
        parameters["productId"] = review.productId
        parameters["text"] = review.text
        parameters["locale"] = review.locale
        parameters["rating"] = review.rating
    }
}

public struct ReviewModel: Codable {
    public let productId: String
    public let locale: String
    public let rating: Double
    public let text: String
}
