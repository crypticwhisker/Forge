//
//  SFRuling.swift
//  Stack
//
//  Created by Jacobs, Joe on 9/2/25.
//

import Foundation

// https://scryfall.com/docs/api/rulings

public struct SFRuling: Codable, Hashable, Sendable {
    public let object: String
    public let oracleID: String
    public let source: String
    public let publishedAt: String
    public let comment: String
}

extension SFRuling {
    enum CodingKeys: String, CodingKey {
        case object
        case oracleID = "oracle_id"
        case source
        case publishedAt = "published_at"
        case comment
    }
}
