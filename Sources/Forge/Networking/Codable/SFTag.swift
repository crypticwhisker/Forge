//
//  SFTag.swift
//  Stack
//
//  Created by Jacobs, Joe on 7/9/26.
//

import Foundation

// https://scryfall.com/docs/api/tags

public struct SFTag: Codable, Hashable, Sendable {
    public let object: String
    public let id: String
    public let slug: String
    public let label: String
    public let uri: String
    public let type: String
    public let description: String?
    public let parentIDs: [String]?
    public let childIDs: [String]?
    public let aliases: [String]?
    public let taggings: [SFTagging]
}

public struct SFTagging: Codable, Hashable, Sendable {
    public let illustrationID: String?
    public let oracleID: String?
    public let weight: String
    public let annotation: String?
}

extension SFTag {
    enum CodingKeys: String, CodingKey {
        case object
        case id
        case slug
        case label
        case uri
        case type
        case description
        case parentIDs = "parent_ids"
        case childIDs = "child_ids"
        case aliases
        case taggings
    }
}

extension SFTagging {
    enum CodingKeys: String, CodingKey {
        case illustrationID = "illustration_id"
        case oracleID = "oracle_id"
        case weight
        case annotation
    }
}
