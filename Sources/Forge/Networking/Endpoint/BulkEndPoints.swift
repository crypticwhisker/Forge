import Foundation

// https://scryfall.com/docs/api/bulk-data/all
struct GetBulkData: Endpoint {
    typealias Response = SFBulkData
    let path: String
    let method: EndpointMethod = .get
    let parameters: [URLQueryItem] = []

    init(type: String) {
        path = "/bulk-data/\(type)"
    }

    init(id: String) {
        path = "/bulk-data/\(id)"
    }
}
