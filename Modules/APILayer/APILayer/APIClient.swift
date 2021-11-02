//
//  APIClient.swift
//  Pods
//
//  Created by Paulo Correa on 1/11/2564 BE.
//
import RxCocoa
import RxSwift

public class APIClient {
    private let baseURLV1 = URL(string: "http://localhost:3001")!
    private let baseURLV2 = URL(string: "http://localhost:3002")!

    public func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        var baseURL: URL
        switch apiRequest.version {
        case .V1:
            baseURL = baseURLV1
        case .V2:
            baseURL = baseURLV2
        }

        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
                .map { try JSONDecoder().decode(T.self, from: $0) }
                .observe(on: MainScheduler.asyncInstance)
    }

    public init() {}
}
