//
//  SFLang.swift
//  Stack
//
//  Created by Jacobs, Joe on 12/2/25.
//

import Foundation

enum SFLanguage: CaseIterable {
    case en
    case es
    case fr
    case de
    case it
    case pt
    case ja
    case ko
    case ru
    case zhs
    case zht
    case he
    case la
    case grc
    case ar
    case sa
    case ph
    case qya
    
    var printedCode: String {
        switch self {
        case .en: return "en"
        case .es: return "sp"
        case .fr: return "fr"
        case .de: return "de"
        case .it: return "it"
        case .pt: return "pt"
        case .ja: return "jp"
        case .ko: return "kr"
        case .ru: return "ru"
        case .zhs: return "cs"
        case .zht: return "ct"
        case .he: return "he"
        case .la: return "la"
        case .grc: return "ag"
        case .ar: return "ar"
        case .sa: return "sa"
        case .ph: return "ph"
        case .qya: return "qya"
        }
    }
    
    var fullName: String {
        switch self {
        case .en: return "English"
        case .es: return "Spanish"
        case .fr: return "French"
        case .de: return "German"
        case .it: return "Italian"
        case .pt: return "Portuguese"
        case .ja: return "Japanese"
        case .ko: return "Korean"
        case .ru: return "Russian"
        case .zhs: return "Simplified Chinese"
        case .zht: return "Traditional Chinese"
        case .he: return "Hebrew"
        case .la: return "Latin"
        case .grc: return "Ancient Greek"
        case .ar: return "Arabic"
        case .sa: return "Sanskrit"
        case .ph: return "Phyrexian"
        case .qya: return "Quenya"
        }
    }
}
