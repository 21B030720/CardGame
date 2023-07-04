import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let emojis = ["👿", "🤖", "🤡", "👺", "A", "😀", "😙", "💃", "👨‍👨‍👧‍👦", "🧕", "🦷", "😺"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    
    @ViewBuilder
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation{
                viewModel.shuffle()
                
            }
        }
    }
    
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
