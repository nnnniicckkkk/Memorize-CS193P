//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/15/24.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    @Published private var game: MemoryGame<String>
    
    private(set) var theme: Theme
  
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis: Array<String> = theme.emojis.shuffled()
        var cardsToShow = theme.numberOfPairsOfCards ?? Int.random(in: 3...theme.emojis.count)
        if cardsToShow > theme.emojis.count {
            cardsToShow = theme.emojis.count
        }
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
                return emojis[pairIndex]
        }
    }
    init(startingTheme: Theme? = nil){
        let selectedTheme = startingTheme ?? themes.randomElement()!
        self.theme = selectedTheme
        game = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    var score: Int {
        return game.score
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    // MARK: - INTENTS
    
    func shuffle() {
        game.shuffle()
    }
    
    func startNewGame() {
        let newTheme = themes.randomElement()!
        self.theme = newTheme
        game = EmojiMemoryGame.createMemoryGame(theme: newTheme)
    }
    

}
