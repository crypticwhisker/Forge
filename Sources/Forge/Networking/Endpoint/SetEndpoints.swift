import Foundation

// https://scryfall.com/docs/api/sets/all
struct GetSets: Endpoint {
    var path: String
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem] = []
    
    init() {
        path = "/sets"
    }
    
    init(id: String) {
        path = "/sets/\(id)"
    }

    init(code: String) {
        path = "/sets/\(code)"
    }
}
