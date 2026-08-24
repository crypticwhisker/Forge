import Foundation
import SwiftUI

// https://scryfall.com/docs/api/layouts

public enum CardLayout: String, Codable, Sendable {
    case normal
    case split
    case flip
    case transform
    case modalDFC = "modal_dfc"
    case meld
    case leveler
    case `class`
    case `case`
    case saga
    case adventure
    case mutate
    case prototype
    case battle // these all appear to be "layout:transform" in the API response
    case planar
    case scheme
    case vanguard
    case token
    case doubleFacedToken = "double_faced_token"
    case emblem
    case augment
    case host
    case artSeries = "art_series"
    case reversibleCard = "reversible_card"
    case prepare
}

extension SFCard {
    public var hasMultipleFaces: Bool {
        switch self.layout {
        case .split, .flip, .prepare, .adventure: return true
        default: return false
        }
    }
    
    public var isDualSided: Bool {
        // Meld cards don't count here as the API doesn't return a card_faces object
        switch self.layout {
        case .transform, .doubleFacedToken, .modalDFC, .reversibleCard, .artSeries: return true
        default: return false
        }
    }
    
    public var displayFaces: [CardLike] {
        if let faces = cardFaces {
            return faces.map { CardLike(face: $0, parentCard: self) }
        } else {
            return [CardLike(card: self)]
        }
    }
    
    public var smallThumbnail: URL? {
        if isDualSided {
            guard
                let face = cardFaces?.first,
                let small = face.imageURIs?.small
            else { return nil }
            return URL(string: small)
        } else {
            guard let small = imageURIs?.small else { return nil }
            return URL(string: small)
        }
    }
    
    public var frontSideName: String {
        if isDualSided {
            guard let frontFace = cardFaces?.first else { return name }
            return frontFace.name
        } else {
            return name
        }
    }
    
    public var frontImageURL: URL? {
        if isDualSided {
            guard
                let face = cardFaces?.first,
                let normal = face.imageURIs?.normal
            else { return nil }
            return URL(string: normal)
        } else {
            guard let normal = imageURIs?.normal else { return nil }
            return URL(string: normal)
        }
    }
    
    public var backImageURL: URL? {
        if isDualSided || hasMultipleFaces {
            guard
                let face = cardFaces?.last,
                let normal = face.imageURIs?.normal
            else { return nil }
            return URL(string: normal)
        } else {
            return nil
        }
    }
    
    public var frontArtCropURL: URL? {
        if isDualSided {
            guard
                let face = cardFaces?.first,
                let art = face.imageURIs?.artCrop
            else { return nil }
            return URL(string: art)
        } else {
            guard let art = imageURIs?.artCrop else { return nil }
            return URL(string: art)
        }
    }
}

