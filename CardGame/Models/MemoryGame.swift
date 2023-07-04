import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // Array of All Cards
    private(set) var cards: Array<Card>
    
    // First Opened Card
    private var indexOfFirst: Int? {
        get { return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    
    // Show Flipside of Chosen Card
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFirst {
                if(cards[chosenIndex].content == cards[potentialMatchIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFirst = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }

    // Struct(Model) of Card
    struct Card: Identifiable {
        let content: CardContent
        var id: Int
        var isFaceUp = false
        var isMatched = false
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
