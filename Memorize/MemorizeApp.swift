//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/12/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
