//
//  SFError.swift
//  Stack
//
//  Created by Jacobs, Joe on 9/2/25.
//

import Foundation

// https://scryfall.com/docs/api/errors

public struct SFError: Decodable, Sendable {
    public let status: Int
    public let code: String
    public let details: String
    public let type: String?
    public let warnings: [String]?
}

extension SFError {
    enum CodingKeys: String, CodingKey {
        case status, code, details, type, warnings
    }
}
