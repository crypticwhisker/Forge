import Foundation

// This is not an exhaustive list of endpoints, only what is currently needed for dependent apps

// https://scryfall.com/docs/api/cards/search
struct GetCardsSearch: Endpoint {
    let path: String = "/cards/search"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
    
    init(
        query: String,
        unique: EndpointUnique? = nil,
        order: EndpointOrder? = nil,
        dir: EndpointDirection? = nil,
        includeExtras: Bool? = nil,
        includeMultilingual: Bool? = nil,
        includeVariations: Bool? = nil,
    ) {
        parameters = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "unique", value: unique?.rawValue),
            URLQueryItem(name: "order", value: order?.rawValue),
            URLQueryItem(name: "dir", value: dir?.rawValue),
            URLQueryItem(name: "include_extras", value: includeExtras?.description),
            URLQueryItem(name: "include_multilingual", value: includeMultilingual?.description),
            URLQueryItem(name: "include_variations", value: includeVariations?.description)
        ]
    }
}

// https://scryfall.com/docs/api/cards/named
struct GetCardsNamed: Endpoint {
    let path: String = "/cards/named"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init(
        exact: String? = nil,
        fuzzy: String? = nil,
        set: String? = nil,
        format: String? = nil,
        face: String? = nil,
        version: String? = nil
    ) {
        parameters = [
            URLQueryItem(name: "exact", value: exact),
            URLQueryItem(name: "fuzzy", value: fuzzy),
            URLQueryItem(name: "set", value: set),
            URLQueryItem(name: "format", value: format),
            URLQueryItem(name: "face", value: face),
            URLQueryItem(name: "version", value: version)
        ]
    }
}

// https://scryfall.com/docs/api/cards/autocomplete
struct GetCardsAutoComplete: Endpoint {
    let path: String = "/cards/autocomplete"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init(
        query: String,
        includeExtras: Bool? = nil
    ) {
        self.parameters = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "include_extras", value: includeExtras?.description)
        ]
    }
    
}

// https://scryfall.com/docs/api/cards/collector
struct GetCardsCollector: Endpoint {
    let path: String = "/cards/collector/"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init (
        code: String,
        number: String,
        lang: String? = nil
    ) {
        parameters = [
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "number", value: number),
            URLQueryItem(name: "lang", value: lang)
        ]
    }
    
}

// https://scryfall.com/docs/api/cards/id
// https://scryfall.com/blog/upcoming-api-changes-to-scryfall-image-uris-and-download-uris-224
// This particular endpoint needs to be public in case clients want to compute a image URI from a scryfall ID
public struct GetCardsID: Endpoint {
    
    public let scryfallID: String
    
    public var path: String {
        return "/cards/\(scryfallID)"
    }
    
    public let method: EndpointMethod = .get
    public var parameters: [URLQueryItem] = []
    
    public enum Format: String {
        case json, text, image
    }
    
    public enum Face: String {
        case back
    }
    
    public enum ImageVersion: String {
        case small
        case normal
        case large
        case png
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }
    
    public init(
        scryfallID: String,
        format: Format? = nil,
        face: Face? = nil,
        version: ImageVersion? = nil
    ) {
        self.scryfallID = scryfallID
        
        parameters = [
            URLQueryItem(name: "format", value: format?.rawValue),
            URLQueryItem(name: "face", value: face?.rawValue),
            URLQueryItem(name: "version", value: version?.rawValue)
        ]
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
    
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}
