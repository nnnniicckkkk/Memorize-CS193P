//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/15/24.
//

import SwiftUI


/// A view model for managing the Emoji Memory Game
class EmojiMemoryGame: ObservableObject {
    // MARK: - Type Aliases
    
    /// The type of cards used in the game
    typealias Card = MemoryGame<String>
    
    // MARK: - Properties
    
    /// The game state
    @Published private var game: Card
    
    /// The theme of the game
    private(set) var theme: Theme
  
    /// Creates a new game with the current theme
    private static func createMemoryGame(theme: Theme) -> Card {
        let emojis: Array<String> = theme.emojis.shuffled()
        var cardsToShow = 10
        if cardsToShow > theme.emojis.count {
            cardsToShow = theme.emojis.count
        }
        return MemoryGame(numberOfPairsOfCards: cardsToShow) { pairIndex in
                return emojis[pairIndex]
        }
    }
    
    // MARK: - Initialization
    
    /// Creates a new Emoji memory game.
    /// - Parameter startingTheme: the starting them of the game. If nil, a random theme is chosen.
    init(startingTheme: Theme? = nil){
        let selectedTheme = startingTheme ?? themes.randomElement()!
        self.theme = selectedTheme
        game = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
    }
    
    // MARK:  - Computed Properties
    
    /// The cards in the game
    var cards: Array<Card.Card> {
        return game.cards
    }
    
    /// The  current score of the game.
    var score: Int {
        return game.score
    }
    
    // MARK:  - Methods
    
    /// Chooses a card in the game.
    /// - Parameter card: The card to choose
    func choose(_ card: Card.Card) {
        game.choose(card: card)
    }

    // Shuffles the cards in the game.
    func shuffle() {
        game.shuffle()
    }
    
    // Starts a new game with a random theme.
    func startNewGame() {
        let newTheme = themes.randomElement()!
        self.theme = newTheme
        game = EmojiMemoryGame.createMemoryGame(theme: newTheme)
    }
    

}
