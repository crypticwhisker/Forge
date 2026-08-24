import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: EndpointMethod { get }
    var parameters: [URLQueryItem] { get }
    func makeURL() throws -> URL
}

// MARK: - Supporting enums
public enum EndpointMethod {
    case get, post
}

public enum EndpointUnique: String {
    case cards, art, prints
}

public enum EndpointDirection: String {
    case auto, asc, desc
}
 
public enum EndpointOrder: String {
    case name, set, released, rarity, color, usd, tix, eur, cmc, power, toughness, edhrec, penny, artist, review
}

extension Endpoint {
    public func makeURL() throws -> URL {
        var components = URLComponents(string: "https://api.scryfall.com")!
        components.path = path
        
        if !parameters.isEmpty {
            components.queryItems = parameters.compactMap { $0.value == nil ? nil : $0}            
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
}
