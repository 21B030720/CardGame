import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👿", "🤖", "🤡", "👺", "A", "😀", "😙", "💃", "👨‍👨‍👧‍👦", "🧕", "🦷", "😺"]

    // Way to Model
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in
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
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card)
    }
}
