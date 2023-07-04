import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👿", "🤖", "🤡", "👺", "A", "😀", "😙", "💃", "👨‍👨‍👧‍👦", "🧕", "🦷", "😺"]

    // Way to Model
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 9) { index in
            emojis[index]
        }
    }
    
    // Observe
//    var objectWillChange: ObservableObjectPublisher

    // Model
    @Published private var model: MemoryGame<String> = createMemoryGame()

//    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4) { index in
//        EmojiMemoryGame.emojis[index]
//    }

    // Cards of Model
    var cards: Array<Card> {
        model.cards
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
//        objectWillChange.send()
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
