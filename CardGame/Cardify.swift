//
//  Cardify.swift
//  CardGame
//
//  Created by Arslan Toimbekov on 01.07.2023.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
                // content which is removed
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(isFaceUp ? 0 : 180), axis: (0, 1, 0))
    }
    
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
