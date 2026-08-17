import Foundation
import SwiftUI
import OSLog

extension URLSession {
    static func scryfallSession() -> URLSession {
        let cache = URLCache(
            memoryCapacity: 50 * 1024 * 1024, // 50 MB
            diskCapacity: 500 * 1024 * 1024 // 500 MB
        )

        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.httpAdditionalHeaders = [
            "User-Agent": "Forge/1.0",
            "Accept": "application/json"
        ]

        return URLSession(configuration: config)
    }
}

public final class ForgeClient: Sendable {
    
    public static let shared = ForgeClient(session: .scryfallSession())
    let session: URLSession
    let decoder: JSONDecoder
    let logger: Logger
    
    init(
        session: URLSession,
        decoder: JSONDecoder = .init(),
        logger: Logger = .init()
    ) {
        self.session = session
        self.decoder = decoder
        self.logger = logger
    }
    
    public func decode<T: Decodable>(data: Data, as type: T.Type) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            logger.debug("\(error)")
            throw FetchError.decodeError
        }
    }
    
    private func fetchAndDecode<T: Decodable>(from endpoint: Endpoint, as type: T.Type) async throws -> T {
        do {
            
            let url = try endpoint.makeURL()
            var request = URLRequest(url: url)
            
            switch endpoint.method {
            case .get:
                request.httpMethod = "GET"
            case .post:
                request.httpMethod = "POST"
            }
            
            let (data, response) = try await session.data(for: request)
            
            // Make sure we get a response at all
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
            // 200-300 is success
            
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 404:
                throw FetchError.noMatchError
            case 503:
                throw FetchError.downError
            default:
                if let apiError = try? decode(data: data, as: SFError.self) {
                    throw FetchError.apiError(apiError)
                }
            }
            
            return try decode(data: data, as: T.self)
        }
    }
    
    /// Fetch all cards for given query
    public func getCardsSearch(for query: String, with options: GetCardsSearchParameters? = nil) async throws -> SFList<SFCard> {
        let endpoint = GetCardsSearch(query: query, options: options)
        return try await fetchAndDecode(from: endpoint, as: SFList<SFCard>.self)
    }
    
    /// Fetch a specific card for a given Scryfall ID
    public func getSpecificCard(for id: String) async throws -> SFCard {
        let endpoint = GetCardsID(scryfallID: id)
        return try await fetchAndDecode(from: endpoint, as: SFCard.self)
    }
    
    /// Fetch rulings for a specific card given that card's rulings URL
    public  func fetchRulingsForCard(for scryfallID: String) async throws -> [SFRuling] {
        let endpoint = AbsoluteURL(url: scryfallID)
        let result = try await fetchAndDecode(from: endpoint, as: SFList<SFRuling>.self)
        return result.data
    }
    
    /// Fetch a random card
    public func fetchRandomCard() async throws -> SFCard {
        let endpoint = GetCardsRandom()
        return try await fetchAndDecode(from: endpoint, as: SFCard.self)
    }
    
    /// Fetch all valid sets
    public func fetchAllSets() async throws -> [SFSet] {
        let endpoint = GetSets()
        let result = try await fetchAndDecode(from: endpoint, as: SFList<SFSet>.self)
        return result.data
    }
    
    /// Fetch a specific set for the given set URL
    public func fetchSpecificSet(for setURI: String) async throws -> SFSet {
        let endpoint = AbsoluteURL(url: setURI)
        return try await fetchAndDecode(from: endpoint, as: SFSet.self)
    }
    
    /// Fetch an array of cards for the given url
    /// Can be used for sets, prints, etc
    public func fetchSpecificURL(for cardURL: String) async throws -> SFList<SFCard> {
        let endpoint = AbsoluteURL(url: cardURL)
        return try await fetchAndDecode(from: endpoint, as: SFList<SFCard>.self)
    }
    
    /// Fetch a card for the given URL
    public func fetchSpecificURLSingle(for cardURL: String) async throws -> SFCard {
        let endpoint = AbsoluteURL(url: cardURL)
        return try await fetchAndDecode(from: endpoint, as: SFCard.self)
    }
    
    /// Fetch an array of strings for the given query
    public func fetchAutoComplete(for query: String, with options: GetCardsAutoCompleteParameters? = nil) async throws -> [String] {
        let endpoint = GetCardsAutoComplete(query: query)
        let result = try await fetchAndDecode(from: endpoint, as: SFCatalog.self)
        return result.data
    }
    
    /// Fetch a catalog for the given URL
    public func fetchCatalog(for catalogURL: String) async throws -> SFCatalog {
        let endpoint = AbsoluteURL(url: catalogURL)
        return try await fetchAndDecode(from: endpoint, as: SFCatalog.self)
    }
    
    /// Fetch bulk data download URL
    public func fetchBulkDataURLByType(for bulkDataType: String) async throws -> SFBulkData {
        let endpoint = GetBulkDataType(type: bulkDataType, parameters: [])
        return try await fetchAndDecode(from: endpoint, as: SFBulkData.self)
    }
}
