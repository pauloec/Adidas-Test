//
//  APIRequest.swift
//  APILayer
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

public protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : Any] { get }
    var version: APIVersion { get }
}

public enum APIVersion {
    case V1, V2
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String("\($1)"))
        }

        guard let url = components.url else {
            fatalError("No URL detected")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

public enum RequestType: String {
    case GET, POST
}
