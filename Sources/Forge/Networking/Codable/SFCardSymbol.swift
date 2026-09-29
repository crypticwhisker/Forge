//
//  SFCardSymbol.swift
//  Stack
//
//  Created by Jacobs, Joe on 8/29/25.
//

import Foundation

// https://scryfall.com/docs/api/card-symbols

public struct SFCardSymbol: Codable, Hashable, Sendable {
    public let object: String
    public let symbol: String
    public let looseVariant: String?
    public let english: String
    public let transposable: Bool?
    public let representsMana: Bool
    public let manaValue: Double?
    public let appearsInManaCosts: Bool
    public let funny: Bool
    public let colors: [String]
    public let hybrid: Bool
    public let phyrexian: Bool
    public let gathererAlternates: [String]?
    public let svgURI: String?
}

extension SFCardSymbol {
    enum CodingKeys: String, CodingKey {
        case object
        case symbol
        case looseVariant = "loose_variant"
        case english
        case transposable
        case representsMana = "represents_mana"
        case manaValue = "mana_value"
        case appearsInManaCosts = "appears_in_mana_costs"
        case funny
        case colors
        case hybrid
        case phyrexian
        case gathererAlternates = "gatherer_alternates"
        case svgURI = "svg_uri"
    }
}
