//
//  SFEndpoint.swift
//  Stack
//
//  Created by Jacobs, Joe on 2/25/26.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: EndpointMethod { get }
    var parameters: [URLQueryItem] { get }
    func makeURL() throws -> URL
}

public enum EndpointMethod {
    case get, post
}

extension Endpoint {
    public func makeURL() throws -> URL {
        var components = URLComponents(string: "https://api.scryfall.com")!
        components.path = path
        components.queryItems = parameters

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
}
