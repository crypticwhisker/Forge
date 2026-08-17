//
//  SFCard.swift
//  Stack
//
//  Created by Jacobs, Joe on 8/18/25.
//

import Foundation

// https://scryfall.com/docs/api/cards

public struct SFCard: Identifiable, Codable, Equatable, Hashable, Comparable, Sendable {
    // Core Card fields
    public let arenaID: Int?
    public let id: String
    public let lang: String
    public let mtgoID: Int?
    public let mtgoFoilID: Int?
    public let multiverseIDs: [Int]?
    public let tcgplayerID: Int?
    public let tcgplayerEtchedID: Int?
    public let cardmarketID: Int?
    public let object: String
    public let layout: CardLayout
    public let oracleID: String?
    public  let printsSearchURI: String
    public let rulingsURI: String
    /// A link to this card’s permapage on Scryfall’s website.
    public let scryfallURI: String
    /// A link to this card object on Scryfall’s API.
    public let uri: String

    // Gameplay fields
    public let allParts: [RelatedCardObjects]?
    public let cardFaces: [CardFaces]?
    public let cmc: Double? // Needs to be optional due to reversible cards
    public let colorIdentity: [String]
    public let colorIndicator: [String]?
    public let colors: [String]?
    public let defense: String?
    public let edhrecRank: Int?
    public let gameChanger: Bool?
    public let foil: Bool // These aren't in the API docs so it's not clear if these are optional or not
    public let nonfoil: Bool
    public let handModifier: String?
    public let keywords: [String]?
    public let legalities: Legalities
    public let lifeModifier: String?
    public let loyalty: String?
    public let manaCost: String?
    public let name: String
    public let oracleText: String?
    public let pennyRank: Int?
    public let power: String?
    public let producedMana: [String]?
    public let isReserved: Bool
    public let toughness: String?
    public let typeLine: String? // Needs to be optional due to reversible cards

    // Print fields
    public let artist: String?
    public let artistIDs: [String]?
    public let attractionLights: [Int]?
    public let booster: Bool
    public let borderColor: String
    public let cardBackID: String?
    public let collectorNumber: String
    public let contentWarning: Bool?
    public let digital: Bool
    public let finishes: [String]
    public let flavorName: String?
    public let flavorText: String?
    public let frameEffects: [String]?
    public let frame: String
    public let games: [String]
    public let highresImage: Bool
    public let illustrationID: String?
    public let imageStatus: String
    public let imageURIs: ImageURIS?
    public let oversized: Bool
    public let prices: Prices
    public let printedName: String?
    public let printedText: String?
    public let printedTypeLine: String?
    public let promo: Bool
    public let promoTypes: [String]?
    public let purchaseURIs: PurchaseURIS?
    public let rarity: String
    public let relatedURIs: RelatedURIS
    public let releasedAt: String
    public let reprint: Bool
    public let scryfallSetURI: String
    public let setName: String
    public let setSearchURI: String
    public let setType: String
    public let setURI: String
    public let set: String
    public let setID: String
    public let storySpotlight: Bool
    public let textless: Bool
    public let variation: Bool
    public let variationOf: String?
    public let securityStamp: String?
    public let watermark: String?
    
    public static func <(lhs: SFCard, rhs: SFCard) -> Bool {
        lhs.name < rhs.name
    }

    public func legality(for format: Format) -> SFCard.Legality {
        let legality = legalities[format]
        if format == .commander, legality == .legal, gameChanger ?? false {
            return .gameChanger
        }

        return legality
    }

    public enum Legality: String, Codable, Sendable {
      case legal
      case notLegal = "not_legal"
      case banned
      case restricted
      case gameChanger

      public var label: String {
        switch self {
        case .legal:
          return "Legal"
        case .notLegal:
          return "Not Legal"
        case .banned:
          return "Banned"
        case .restricted:
          return "Restricted"
        case .gameChanger:
          return "Legal/GC"

        }
      }
    }
}

public enum Format: String, CaseIterable {
    case standard = "standard"
    case modern = "modern"
    case pioneer = "pioneer"
    case vintage = "vintage"
    case commander = "commander"
    case legacy = "legacy"
    case pauper = "pauper"
    case oathbreaker = "oathbreaker"
    case alchemy = "alchemy"
    case historic = "historic"
    case brawl = "brawl"
    case timeless = "timeless"
    case penny = "penny"
}

// MARK: - Supporting structs
public struct CardFaces: Codable, Equatable, Hashable, Sendable {
    public let artist: String?
    public let artistID: String?
    public let cmc: Double?
    public let colorIndicator: [String]?
    public let colors: [String]?
    public let defense: String?
    public let flavorText: String?
    public let illustrationID: String?
    public let imageURIs: ImageURIS?
    public let layout: CardLayout?
    public let loyalty: String?
    public let manaCost: String?
    public let name: String
    public let object: String
    public let oracleID: String?
    public let oracleText: String?
    public let power: String?
    public let printedName: String?
    public let printedText: String?
    public let printedTypeLine: String?
    public let toughness: String?
    public let typeLine: String?
    public let watermark: String?
}

public struct Prices: Codable, Equatable, Hashable, Sendable {
    public let usd: String?
    public let usdFoil: String?
    public let usdEtched: String?
    public let eur: String?
    public let eurFoil: String?
    public let eurEtched: String?
    public let tix: String?
}

public struct PurchaseURIS: Codable, Equatable, Hashable, Sendable {
    public let tcgplayer: String?
    public let cardmarket: String?
    public let cardhoarder: String?
}

public struct ImageURIS: Codable, Equatable, Hashable, Sendable {
    public let png: String
    public let borderCrop: String
    public let artCrop: String
    public let small: String
    public let normal: String
    public let large: String
}

public struct RelatedURIS: Codable, Equatable, Hashable, Sendable {
    public let gatherer: String?
    public let tcgplayerInfiniteArticles: String?
    public let tcgplayerInfiniteDecks: String?
    public let edhrec: String?
}

public struct RelatedCardObjects: Codable, Equatable, Hashable, Sendable {
    public let id: String
    public let object: String
    public let component: String
    public let name: String
    public let typeLine: String
    public let uri: String
}

public struct Legalities: Codable, Equatable, Hashable, Sendable {
    public let standard: SFCard.Legality
    public let pioneer: SFCard.Legality
    public let modern: SFCard.Legality
    public let legacy: SFCard.Legality
    public let vintage: SFCard.Legality
    public let commander: SFCard.Legality
    public let oathbreaker: SFCard.Legality
    public let alchemy: SFCard.Legality
    public let historic: SFCard.Legality
    public let brawl: SFCard.Legality
    public let timeless: SFCard.Legality
    public let pauper: SFCard.Legality
    public let penny: SFCard.Legality

    subscript(format: Format) -> SFCard.Legality {
        switch format {
        case .standard: return standard
        case .modern: return modern
        case .commander: return commander
        case .vintage: return vintage
        case .pauper: return pauper
        case .legacy: return legacy
        case .brawl: return brawl
        case .alchemy: return alchemy
        case .pioneer: return pioneer
        case .historic: return historic
        case .timeless: return timeless
        case .penny: return penny
        case .oathbreaker: return oathbreaker
        }
    }
}

// MARK: - Coding keys
extension SFCard {
    enum CodingKeys: String, CodingKey {
        // Core Card fields
        case arenaID = "arena_id"
        case id
        case lang
        case mtgoID = "mtgo_id"
        case mtgoFoilID = "mtgo_foil_id"
        case multiverseIDs = "multiverse_ids"
        case tcgplayerID = "tcgplayer_id"
        case tcgplayerEtchedID = "tcgplayer_etched_id"
        case cardmarketID = "cardmarket_id"
        case object
        case layout
        case oracleID = "oracle_id"
        case printsSearchURI = "prints_search_uri"
        case rulingsURI = "rulings_uri"
        case scryfallURI = "scryfall_uri"
        case uri

        // Gameplay fields
        case allParts = "all_parts"
        case cardFaces = "card_faces"
        case cmc
        case colorIdentity = "color_identity"
        case colorIndicator = "color_indicator"
        case colors
        case defense
        case edhrecRank = "edhrec_rank"
        case gameChanger = "game_changer"
        case foil
        case nonfoil
        case handModifier = "hand_modifier"
        case keywords
        case legalities
        case lifeModifier = "life_modifier"
        case loyalty
        case manaCost = "mana_cost"
        case name
        case oracleText = "oracle_text"
        case pennyRank = "penny_rank"
        case power
        case producedMana = "produced_mana"
        case isReserved = "reserved"
        case toughness
        case typeLine = "type_line"

        // Print fields
        case artist
        case artistIDs = "artist_ids"
        case attractionLights = "attraction_lights"
        case booster
        case borderColor = "border_color"
        case cardBackID = "card_back_id"
        case collectorNumber = "collector_number"
        case contentWarning = "content_warning"
        case digital
        case finishes
        case flavorName = "flavor_name"
        case flavorText = "flavor_text"
        case frameEffects = "frame_effects"
        case frame
        case games
        case highresImage = "highres_image"
        case illustrationID = "illustration_id"
        case imageStatus = "image_status"
        case imageURIs = "image_uris"
        case oversized
        case prices
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
        case promo
        case promoTypes = "promo_types"
        case purchaseURIs = "purchase_uris"
        case rarity
        case relatedURIs = "related_uris"
        case releasedAt = "released_at"
        case reprint
        case scryfallSetURI = "scryfall_set_uri"
        case setName = "set_name"
        case setSearchURI = "set_search_uri"
        case setType = "set_type"
        case setURI = "set_uri"
        case set
        case setID = "set_id"
        case storySpotlight = "story_spotlight"
        case textless
        case variation
        case variationOf = "variation_of"
        case securityStamp = "security_stamp"
        case watermark
    }
}

extension CardFaces {
    enum CodingKeys: String, CodingKey {
        case artist
        case artistID = "artist_id"
        case cmc
        case colorIndicator = "color_indicator"
        case colors
        case defense
        case flavorText = "flavor_text"
        case illustrationID = "illustration_id"
        case imageURIs = "image_uris"
        case layout
        case loyalty
        case manaCost = "mana_cost"
        case name
        case object
        case oracleID = "oracle_id"
        case oracleText = "oracle_text"
        case power
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
        case toughness
        case typeLine = "type_line"
        case watermark
    }
}

extension Prices {
    enum CodingKeys: String, CodingKey {
        case usd
        case usdFoil = "usd_foil"
        case usdEtched = "usd_etched"
        case eur
        case eurFoil = "eur_foil"
        case eurEtched = "eur_etched"
        case tix
    }
}

extension ImageURIS {
    enum CodingKeys: String, CodingKey {
        case png
        case borderCrop = "border_crop"
        case artCrop = "art_crop"
        case small
        case normal
        case large
    }
}

extension RelatedURIS {
    enum CodingKeys: String, CodingKey {
        case gatherer
        case tcgplayerInfiniteArticles = "tcgplayer_infinite_articles"
        case tcgplayerInfiniteDecks = "tcgplayer_infinite_decks"
        case edhrec
    }
}

extension RelatedCardObjects {
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case component
        case name
        case typeLine = "type_line"
        case uri
    }
}

extension PurchaseURIS {
    enum CodingKeys: String, CodingKey {
        case tcgplayer
        case cardmarket
        case cardhoarder
    }
}
