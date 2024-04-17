//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/12/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    var aspectRatio: CGFloat = 2/3

    var body: some View {
        ZStack{
                background
                VStack(spacing: 0) {
                    ScrollView{
                        cards
                            .animation(.default, value: game.cards)
                            
                    }
                    
                    
                    Group{
                        header
                            
                        scoreButtonView
                        
                    }
                    .background(.ultraThinMaterial)
                    
                }
                .foregroundStyle(game.theme.baseColor)
                .padding()
        }
    }
    
    private var background: some View {
        LinearGradient(colors:
                        [game.theme.baseColor.opacity(0),
                         game.theme.baseColor.opacity(0.2),
                         game.theme.baseColor.opacity(0.4),
                         game.theme.baseColor.opacity(0.4),
                         game.theme.baseColor.opacity(0.5),
                        ],
                       startPoint: .bottom,
                       endPoint: .top).ignoresSafeArea()
    }
    private var header: some View {
        HStack{
            ZStack {
                Text("Memorize!")
                    .foregroundStyle(.white)
                Text("Memorize!")
            }
                .font(.largeTitle)
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(game.theme.baseColor.opacity(0.75))
                    
                Text("\(game.theme.name) theme")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            .frame(maxHeight: 25)
            .onTapGesture {
                game.startNewGame()
            }
        }
        
    }
    
    private var cards: some View {
        AspectVGrid(items: game.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(3)
                
               
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
    
    
    
    private var scoreButtonView: some View {
        VStack {
            HStack{
                HStack{
                    Text("Score: ")
                    Spacer()
                    Text("\(game.score)")
                        .padding(.trailing, 10)
                }
                .font(.title)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(game.theme.baseColor.opacity(0.75))
                .cornerRadius(10)
                
                Button("Start a new game!") {
                    game.startNewGame()
                }
                .buttonStyle(.borderedProminent)
                .tint(game.theme.baseColor.opacity(0.2))
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
