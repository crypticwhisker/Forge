//
//  FetchError.swift
//  ScryGuy
//
//  Created by Jacobs, Joe on 2/25/26.
//

import Foundation

public enum FetchError: LocalizedError {
    case decodeError
    case downError
    case noMatchError
    case apiError(SFError)
    
    public var errorDescription: String {
        switch self {
        case .decodeError:
            return "Error decoding Scryfall response"
        case .downError:
            return "No response from Scryfall. Is it down?"
        case .noMatchError:
            return "No match found. Please try a different search." // Hijacking the response here as Scryfall's response isn't that helpful
        case .apiError(let error):
            return error.warnings?.joined(separator: "\n") ?? error.details
        }
    }
}
