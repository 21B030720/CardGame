import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // Array of All Cards
    private(set) var cards: Array<Card>
    
    // First Opened Card
    private var indexOfFirst: Int?
    
    
    // Show Flipside of Chosen Card
    mutating func choose(_ card: Card) {
//        if let copyIndex = cards.firstIndex(where: { C in
//            C.id == card.id}) {
//            cards[copyIndex].isFaceUp.toggle()
//        }
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFirst {
                if(cards[chosenIndex].content == cards[potentialMatchIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfFirst = nil
            } else {
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                indexOfFirst = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            
        }
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }

    }

    // Struct(Model) of Card
    struct Card: Identifiable {
        let content: CardContent
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
}
