//
//  AbsoluteURL.swift
//  Stack
//
//  Created by Jacobs, Joe on 2/26/26.
//

import Foundation

// Endpoint for when we already have the full Scryfall URL
struct AbsoluteURL: Endpoint {
    let url: String
    
    var path: String { url }
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    func makeURL() throws -> URL {
        guard let url = URL(string: path) else {
            throw URLError(.badURL)
        }
            
        return url
    }
}
