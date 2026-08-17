//
//  CardEndpoints.swift
//  Stack
//
//  Created by Jacobs, Joe on 2/25/26.
//

import Foundation

// This is not an exhaustive list of endpoints, only what is currently needed by the app

// https://scryfall.com/docs/api/cards/manifest

struct GetCardsManifest: Endpoint {
    let path: String = "/cards/manifest"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
}

// https://scryfall.com/docs/api/cards/search
struct GetCardsSearch: Endpoint {
    let path: String = "/cards/search"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
    
    init(
        query: String,
        options: GetCardsSearchParameters? = nil
    ) {
        
        var items: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query),
        ]
        
        if let unique = options?.unique {
            let item = URLQueryItem(name: "unique", value: unique.rawValue)
            items.append(item)
        }
        
        if let order = options?.order {
            let item = URLQueryItem(name: "order", value: order.rawValue)
            items.append(item)
        }
        
        if let dir = options?.dir {
            let item = URLQueryItem(name: "dir", value: dir.rawValue)
            items.append(item)
        }
        
        if let _ = options?.includeExtras {
            let item = URLQueryItem(name: "include_extras", value: "true")
            items.append(item)
        }
        
        if let _ = options?.includeMultilingual {
            let item = URLQueryItem(name: "include_multilingual", value: "true")
            items.append(item)
        }
        
        if let _ = options?.includeVariations {
            let item = URLQueryItem(name: "include_variations", value: "true")
            items.append(item)
        }
        
        self.parameters = items
    }
}

public struct GetCardsSearchParameters {
    var unique: Unique?
    var order: Order?
    var dir: Direction?
    var includeExtras: Bool?
    var includeMultilingual: Bool?
    var includeVariations: Bool?
}

enum Unique: String {
    case cards, art, prints
}

enum Order: String {
    case auto, asc, desc
}
 
enum Direction: String {
    case name, set, released, rarity, color, usd, tix, eur, cmc, power, toughness, edhrec, penny, artist, review
}

// https://scryfall.com/docs/api/cards/named
struct GetCardsNamed: Endpoint {
    var path: String = "/cards/named"
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/cards/autocomplete
struct GetCardsAutoComplete: Endpoint {
    var path: String = "/cards/autocomplete"
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init(
        query: String,
        options: GetCardsAutoCompleteParameters? = nil
    ) {
        var items: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query),
        ]
        
        if let _ = options?.includeExtras {
            let item = URLQueryItem(name: "include_extras", value: "true")
            items.append(item)
        }
        
        self.parameters = items
    }
    
}

public struct GetCardsAutoCompleteParameters {
    var includeExtras: Bool?
}

// https://scryfall.com/docs/api/cards/collector
struct GetCardsCollector: Endpoint {
    
    let options: GetCardsCollectorParameters
    
    var path: String {
        if let lang = options.lang {
            "/cards/collector/\(options.set)/\(options.code)/\(lang)"
        } else {
            "/cards/collector/\(options.code)/\(options.set)"
        }
    }
        
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

struct GetCardsCollectorParameters {
    var set: String
    var code: String
    var lang: String?
}

// https://scryfall.com/docs/api/cards/id
public struct GetCardsID: Endpoint {
    public let scryfallID: String
    
    public var path: String {
        return "/cards/\(scryfallID)"
    }
    
    public var method: EndpointMethod = .get
    public var parameters: [URLQueryItem]
    
    public init(
        scryfallID: String,
        options: GetCardsIDParameters? = nil
    ) {
        self.scryfallID = scryfallID
        
        var items: [URLQueryItem] = []
        
        if let format = options?.format {
            let item = URLQueryItem(name: "format", value: format)
            items.append(item)
        }
        
        if let version = options?.version {
            let item = URLQueryItem(name: "version", value: version)
            items.append(item)
        }
        
        self.parameters = items
    }
}

public struct GetCardsIDParameters {
    public var format: String?
    public var version: String?
    
    public init(
        format: String?,
        version: String?
    ) {
        self.format = format
        self.version = version
    }
}

// https://scryfall.com/docs/api/cards/random
struct GetCardsRandom: Endpoint {
    var path: String = "/cards/random"
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/rulings/id
struct GetCardRulings: Endpoint {
    let scryfallID: String
    
    var path: String {
        return "/cards/\(scryfallID)/rulings"
    }
    
    var method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/cards/collection
struct PostCardsCollection: Endpoint {
    var path: String = "/cards/collection"
    var method: EndpointMethod = .post
    var parameters: [URLQueryItem] = []
}
