//
//  APIClient.swift
//  Pods
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

class APIClient {
    private let baseURL = URL(string: "http://localhost:3001/")!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
            .map {
                try JSONDecoder().decode(T.self, from: data)
            }
            .observeOn(MainScheduler.asyncInstance)
    }
}
