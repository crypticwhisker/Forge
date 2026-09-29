import Foundation

// https://scryfall.com/docs/api/sets/all
struct GetSetsAll: Endpoint {
    typealias Response = SFList<SFSet>
    var path = "/sets"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
}

// https://scryfall.com/docs/api/sets/id
struct GetSetByID: Endpoint {
    typealias Response = SFSet
    var path: String
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init(id: String) {
        path = "/sets/\(id)"
    }
}

// https://scryfall.com/docs/api/sets/code
struct GetSetByCode: Endpoint {
    typealias Response = SFSet
    var path: String
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init(code: String) {
        path = "/sets/\(code)"
    }
}
