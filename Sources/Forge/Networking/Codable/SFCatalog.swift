//
//  SFCatalog.swift
//  Stack
//
//  Created by Jacobs, Joe on 9/2/25.
//

import Foundation

// https://scryfall.com/docs/api/catalogs

public struct SFCatalog: Decodable {
    public let object: String
    public let uri: String?
    public let totalValues: Int
    public let data: [String]
}

extension SFCatalog {
    enum CodingKeys: String, CodingKey {
        case object
        case uri
        case totalValues = "total_values"
        case data
    }
}
