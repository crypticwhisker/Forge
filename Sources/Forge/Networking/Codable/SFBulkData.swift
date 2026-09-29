//
//  SFBulkData.swift
//  Stack
//
//  Created by Jacobs, Joe on 7/9/26.
//

import Foundation

// https://scryfall.com/docs/api/bulk-data

public struct SFBulkData: Codable, Hashable, Sendable {
    public let id: String
    public let uri: String
    public let type: String
    public let name: String
    public let description: String
    public let jsonlDOwnloadURI: String
    public let updatedAt: String
    public let compressedSize: Int
}

extension SFBulkData {
    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case type
        case name
        case description
        case jsonlDOwnloadURI = "jsonl_download_uri"
        case updatedAt = "updated_at"
        case compressedSize = "compressed_size"
    }
}
