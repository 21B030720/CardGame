import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            // Two Sides of the Card and Effect of Flipping
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
                // content which is removed
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0) // The Card is Face Up or Down
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0)) // Rotation effect
    }
    
    // Constants
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
