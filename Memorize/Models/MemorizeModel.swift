//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/15/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    private(set) var score = 0
    private var seenCards = [Card]()
    
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
    var indexOfOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(of: card), !cards[chosenIndex].isMatched {
               if let potentialMatchIndex = indexOfOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                   if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                       cards[chosenIndex].isMatched = true
                       cards[potentialMatchIndex].isMatched = true

                       score += Int(2 /** multiplier*/)
                   }
                   else {
                       score += seenCards.firstIndex(of: cards[potentialMatchIndex]) != nil && seenCards.firstIndex(of: cards[chosenIndex]) != nil ? 0 : -1
                      
                   }
                   cards[chosenIndex].isFaceUp = true
               }
               else {
                   indexOfOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var hasBeenSeenThisManyTimes: Int = 0
    }
}

extension Array {
    var only: Element? {
       count == 1 ? first : nil
    }
}
