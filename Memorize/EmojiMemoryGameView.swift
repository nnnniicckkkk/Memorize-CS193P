//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/12/24.
//

import SwiftUI




struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View {
        ZStack {
            
            VStack {
                VStack {
                    Text("Memorize!")
                        .font(.largeTitle)
                    Text("\(game.theme.name) theme")
                        .font(.caption)
                        .foregroundStyle(game.theme.baseColor.opacity(0.75))
                }
                ScrollView {
                    cards
                        .animation(.default, value: game.cards)
                }
                Spacer()
                HStack {
                    Text("Score: ")
                        .font(.title)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.white)
                        .background(game.theme.baseColor.opacity(0.75))
                        .cornerRadius(10)
                    Button("Start a new game!") {
                        game.startNewGame()
                    }
                }
            }
            
        }
        .foregroundStyle(game.theme.baseColor)
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)]) {
            ForEach(game.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            
        }
        
    }
    
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
                
                
            Group {
                base.fill(.white)
                
                base.strokeBorder(lineWidth: 2)
                
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
        
        
    }
}

#Preview {
    EmojiMemoryGameView(game: EmojiMemoryGame())
}
