//
//  SFList.swift
//  Stack
//
//  Created by Jacobs, Joe on 9/2/25.
//

import Foundation

// https://scryfall.com/docs/api/lists

public struct SFList <T: Codable & Hashable & Sendable>: Codable, Sequence, Hashable, Sendable {
    public let object: String
    public let data: [T]
    public let hasMore: Bool
    public let nextPage: String?
    public let totalCards: Int?
    public let warnings: [String]?

    public func makeIterator() -> IndexingIterator<[T]> {
        return data.makeIterator()
    }
}

extension SFList {
    enum CodingKeys: String, CodingKey {
        case object
        case data
        case hasMore = "has_more"
        case nextPage = "next_page"
        case totalCards = "total_cards"
        case warnings
    }
}
