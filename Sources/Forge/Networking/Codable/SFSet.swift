//
//  SFSet.swift
//  Stack
//
//  Created by Jacobs, Joe on 8/27/25.
//

import Foundation

// https://scryfall.com/docs/api/sets

public struct SFSet: Codable, Hashable {
    public let object: String
    public let id: String
    public let code: String
    public let mtgoCode: String?
    public let arenaCode: String?
    public let tcgplayerID: Int?
    public let name: String
    public let setType: String
    public let releasedAt: String?
    public let blockCode: String?
    public let block: String?
    public let parentSetCode: String?
    public let cardCount: Int
    public let printedSize: Int?
    public let digital: Bool
    public let foilOnly: Bool? // not marked as optional by Scryfall but is
    public let nonFoilOnly: Bool? // not marked as optional by Scryfall but is
    public let scryfallURI: String
    public let uri: String
    public let iconSvgURI: String
    public let searchURI: String
}

extension SFSet {
    enum CodingKeys: String, CodingKey {
        case object
        case id
        case code
        case mtgoCode = "mtgo_code"
        case arenaCode = "arena_code"
        case tcgplayerID = "tcgplayer_id"
        case name
        case setType = "set_type"
        case releasedAt = "released_at"
        case blockCode = "block_code"
        case block
        case parentSetCode = "parent_set_code"
        case cardCount = "card_count"
        case printedSize = "printed_size"
        case digital
        case foilOnly = "foil_only"
        case nonFoilOnly = "non_foil_only"
        case scryfallURI = "scryfall_uri"
        case uri
        case iconSvgURI = "icon_svg_uri"
        case searchURI = "search_uri"
    }
}
