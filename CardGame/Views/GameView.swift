//import SwiftUI
//
//struct GameView: View {
//    var content: String
//    @State var isFaceUp: Bool = true
//
//    var body: some View {
//
//        ZStack {
//            let shape = RoundedRectangle(cornerRadius: 20)
//            if isFaceUp {
//                shape.fill().foregroundColor(.white)
//                shape.stroke(lineWidth: 3)
//                Text(content).font(.largeTitle)
//            } else {
//                shape.fill()
//            }
//        }
//        .onTapGesture {
//            isFaceUp = !isFaceUp
//        }
//
//
//    }
//}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(content: "A")
//    }
//}
