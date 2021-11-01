//
//  APIClient.swift
//  Pods
//
//  Created by Paulo Correa on 1/11/2564 BE.
//
import RxCocoa
import RxSwift

public class APIClient {
    private let baseURL = URL(string: "http://localhost:3001/")!

    public func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
                .map { try JSONDecoder().decode(T.self, from: $0) }
                .observe(on: MainScheduler.asyncInstance)
    }

    public init() {}
}
