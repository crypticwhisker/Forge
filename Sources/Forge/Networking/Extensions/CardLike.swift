import Foundation

public struct CardLike {
    public let id: UUID
    public let name: String
    public let flavorName: String?
    public let manaCost: String?
    public let typeLine: String?
    public let oracleText: String?
    public let flavorText: String?
    public let pt: String?
    public let loyalty: String?
    public let attractionLights: [Int]?
}

extension CardLike {
    init(card: SFCard) {
        let usePrinted = card.lang != "en" && card.lang != "ph" && card.lang != "qya"
        
        self.init(
            id: UUID(),
            name: usePrinted ? (card.printedName ?? card.name) : card.name,
            flavorName: card.flavorName,
            manaCost: card.manaCost,
            typeLine: usePrinted ? (card.printedTypeLine ?? card.typeLine) : card.typeLine,
            oracleText: usePrinted ? (card.printedText ?? card.oracleText) : card.oracleText,
            flavorText: card.flavorText,
            pt: card.power != nil && card.toughness != nil
                ? "\(card.power!)/\(card.toughness!)"
                : nil,
            loyalty: card.loyalty,
            attractionLights: card.attractionLights
        )
    }

    init(face: CardFaces, parentCard: SFCard) {
        let usePrinted = parentCard.lang != "en" && parentCard.lang != "ph" && parentCard.lang != "qya"

        self.init(
            id: UUID(),
            name: usePrinted ? (face.printedName ?? face.name) : face.name,
            flavorName: parentCard.flavorName,
            manaCost: face.manaCost,
            typeLine: usePrinted ? (face.printedTypeLine ?? face.typeLine) : face.typeLine,
            oracleText: usePrinted ? (face.printedText ?? face.oracleText) : face.oracleText,
            flavorText: face.flavorText,
            pt: face.power != nil && face.toughness != nil
                ? "\(face.power!)/\(face.toughness!)"
                : nil,
            loyalty: face.loyalty,
            attractionLights: nil
        )
    }
}
