//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/15/24.
//

import Foundation
/// A game model representing a memory card game
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    //MARK: - Properties
    
    /// The array of cards in the game
    private(set) var cards: [Card]
    
    /// The current score in the game
    private(set) var score = 0
    
    /// The array of cards that have been seen in the game
    private var seenCards = [Card]()
    
    
    // MARK:  - Initialization
    
    /// Initializes a new game
    /// - Parameters:
    ///    - numberOfPairsOfCards: The number of pairs of cards in the game to begin the game.
    ///    - cardContentFactory: A closure to create card content based on pair index of cards.
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
            cards = Array<Card>()
            // add number of pairs of cards x 2 cards to card array
            for pairIndex in 0..<numberOfPairsOfCards {
                let content: CardContent = cardContentFactory(pairIndex)
                cards.append(Card(content: content, id: "\(pairIndex)1a"))
                cards.append(Card(content: content, id: "\(pairIndex)1b"))
            }
            cards.shuffle()
        }
    
    // MARK: - Computed Properties
    
    /// The index of the only face-up card if there is one selected.
    var indexOfOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    // MARK: - Methods
    
    /// Chooses a card and updates the game state.
    ///  - parameter card: the card to choose
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(of: card), !cards[chosenIndex].isMatched {
               if let potentialMatchIndex = indexOfOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                   if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                       cards[chosenIndex].isMatched = true
                       cards[potentialMatchIndex].isMatched = true
                       score += Int(2 /** multiplier*/)
                   }
                   else {
                       score += seenCards.firstIndex(of: cards[potentialMatchIndex]) != nil
                       && seenCards.firstIndex(of: cards[chosenIndex]) != nil ? 0 : -1
                   }
                   cards[chosenIndex].isFaceUp = true
               }
               else {
                   indexOfOnlyFaceUpCard = chosenIndex
                   
            }
        }
    }
    
    /// Shuffles the cards
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // MARK: Types
    
    /// A single card in the game
    struct Card: Equatable, Identifiable {
        var isFaceUp = false 
        var isMatched = false
        let content: CardContent
        
        var id: String
        var hasBeenSeenThisManyTimes: Int = 0
    }
}


// MARK: - Extensions
extension Array {
    
    // Returns the only element in the array if there is exactly one element.
    var only: Element? {
       count == 1 ? first : nil
    }
}
