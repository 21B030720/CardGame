//
//  CardGameApp.swift
//  CardGame
//
//  Created by Arslan Toimbekov on 19.06.2023.
//

import SwiftUI

@main
struct CardGameApp: App {
    private let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
