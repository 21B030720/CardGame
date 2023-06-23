import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let emojis = ["👿", "🤖", "🤡", "👺", "A", "😀", "😙", "💃", "👨‍👨‍👧‍👦", "🧕", "🦷", "😺"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer(minLength: 20)
            
            HStack {
                removeButton
                
                Spacer()
                
                addButton
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding()
        
    }
    
    @ViewBuilder
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
        EmojiMemoryGameView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
        EmojiMemoryGameView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
            .preferredColorScheme(.dark)
    }
}
