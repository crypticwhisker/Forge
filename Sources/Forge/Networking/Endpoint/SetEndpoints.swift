//
//  SetEndpoints.swift
//  Stack
//
//  Created by Jacobs, Joe on 2/25/26.
//

import Foundation

// https://scryfall.com/docs/api/sets/all
struct GetSets: Endpoint {
    var path: String = "/sets"
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/sets/code
struct GetSetsByCode: Endpoint {
    let code: String
    
    var path: String {
        return "/sets/\(code)"
    }
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/sets/id
struct GetSetByID: Endpoint {
    let setID: String
    
    var path: String {
        return "/sets/\(setID)"
    }
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}
