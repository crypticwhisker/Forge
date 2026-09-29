import Foundation
import SwiftUI
import OSLog

public final class ForgeClient: Sendable {
    
    let network: ForgeNetworkProtocol
    
    public init(
        session: URLSession
    ) {
        self.network = ForgeNetwork(session: session)
    }
    
    /// Fetch all cards for given query
    public func getCardsSearch(
        query: String,
        unique: EndpointUnique? = nil,
        order: EndpointOrder? = nil,
        dir: EndpointDirection? = nil,
        includeExtras: Bool? = nil,
        includeMultilingual: Bool? = nil,
        includeVariations: Bool? = nil
    ) async throws -> SFList<SFCard> {
        let endpoint = GetCardsSearch(
            query: query,
            unique: unique,
            order: order,
            dir: dir,
            includeExtras: includeExtras,
            includeMultilingual: includeMultilingual,
            includeVariations: includeVariations
        )
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch a specific card for a given Scryfall ID
    public func getSpecificCard(id: String) async throws -> SFCard {
        let endpoint = GetCardsID(scryfallID: id)
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch rulings for a specific card given that card's rulings URL
    public func fetchRulingsForCard(rulingURL: String) async throws -> [SFRuling] {
        let result = try await network.fetchAndDecode(from: rulingURL, as: SFList<SFRuling>.self)
        return result.data
    }
    
    /// Fetch a random card
    public func fetchRandomCard() async throws -> SFCard {
        let endpoint = GetCardsRandom()
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch all valid sets
    public func fetchAllSets() async throws -> [SFSet] {
        let endpoint = GetSetsAll()
        let result = try await network.fetchAndDecode(from: endpoint)
        return result.data
    }
    
    /// Fetch all a spefici set for the given set ID
    public func fetchSpecificSet(id: String) async throws -> SFSet {
        let endpoint = GetSetByID(id: id)
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch all a specific set for the given set code ie "ltr"
    public func fetchSpecificSet(code: String) async throws -> SFSet {
        let endpoint = GetSetByCode(code: code)
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch a specific set for the given set URL
    /// Mainly used when you already have the set URL, such as when you have a card loaded
    public func fetchSpecificSet(setURI: String) async throws -> SFSet {
        return try await network.fetchAndDecode(from: setURI, as: SFSet.self)
    }
    
    /// Fetch an array of cards for the given url
    /// Mainly used to grab prints of cards
    public func fetchSpecificURLMultiple(url: String) async throws -> SFList<SFCard> {
        return try await network.fetchAndDecode(from: url, as: SFList<SFCard>.self)
    }
    
    /// Fetch a card for the given URL
    public func fetchSpecificURLSingle(cardURL: String) async throws -> SFCard {
        return try await network.fetchAndDecode(from: cardURL, as: SFCard.self)
    }
    
    /// Fetch an array of strings for the given query
    public func fetchAutoComplete(query: String, includeExtras: Bool? = nil) async throws -> [String] {
        let endpoint = GetCardsAutoComplete(query: query, includeExtras: includeExtras)
        let result = try await network.fetchAndDecode(from: endpoint)
        return result.data
    }
    
    /// Fetch a catalog for the given URL
    public func fetchCatalog(for catalogURL: String) async throws -> SFCatalog {
        return try await network.fetchAndDecode(from: catalogURL, as: SFCatalog.self)
    }
    
    /// Fetch bulk data object given the provided type ie "oracle-tags"
    public func fetchBulkDataURL(bulkDataType: String) async throws -> SFBulkData {
        let endpoint = GetBulkData(type: bulkDataType)
        return try await network.fetchAndDecode(from: endpoint)
    }
    
    /// Fetch bulk data object given the provided ID
    public func fetchBulkDataURL(bulkDataID: String) async throws -> SFBulkData {
        let endpoint = GetBulkData(id: bulkDataID)
        return try await network.fetchAndDecode(from: endpoint)
    }
}
