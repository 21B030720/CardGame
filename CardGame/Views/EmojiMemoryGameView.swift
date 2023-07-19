import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()
    
    let emojis = ["👿", "🤖", "🤡", "👺", "A", "😀", "😙", "💃", "👨‍👨‍👧‍👦", "🧕", "🦷", "😺"]
    @State var emojiCount = 4
    
    ///
    ///
    ///
    ///
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody // every is on his place
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody // all cards on one place
        }
        .padding()
    }
    ///
    ///
    ///
    ///
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    // Анимация растасовки карт
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation{
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        Double(viewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    // Game is Started
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace) // connection to animation of deckBody
                    .padding(4)
                    .transition(.asymmetric(insertion: .identity, removal: .scale)) // insertion has to be identity
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.choose(card)
                        }
                    }
            }
        }
//        .onAppear {
//            withAnimation(.easeInOut(duration: 3)) {
//                for card in viewModel.cards {
//                    deal(card)
//                }
//            }
//        }
        .foregroundColor(CardConstants.color)
    }
    
    // One Card
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace) // connection to animation of gameBody
                    .zIndex(zIndex(of: card))
                    .transition(.asymmetric(insertion: .opacity, removal: .identity)) // removal has to be identity
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for card in viewModel.cards {
                // анимация растасовки
                withAnimation(dealAnimation(for: card)) {
                    deal(card) // From deckBody to gameBody
                }
            }
        }
    }
    
    // Change Positions of Cards
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
                
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                viewModel.restart()
            }
        }
    }
    
    // Buttons
    var removeButton: some View {
        
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            VStack {
                Image(systemName: "minus.circle")
            }
        }
    }
    var addButton: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            VStack {
                Image(systemName: "plus.circle")
            }
        }
    }
    
    // Constants
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth: CGFloat = undealHeight * aspectRatio
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
        
//        EmojiMemoryGameView(viewModel: game)
//            .previewInterfaceOrientation(.portrait)
//            .preferredColorScheme(.dark)
    }
}
