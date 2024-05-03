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
                    .scrollClipDisabled()
                    .zIndex(2)
                    
                    
                    Group{
                        header
                            .zIndex(1)
                            
                        scoreButtonView
                        
                    }
                    .offset(y: 20)
                   
                    
                }
                .foregroundStyle(game.theme.baseColor)
                .padding()
        }
    }
    
    private var background: some View {
        
        
        LinearGradient(colors: backgroundColors,
                       startPoint: .bottom,
                       endPoint: .top).ignoresSafeArea()
    }
    
    private var backgroundColors: [Color] {
        [game.theme.baseColor.opacity(0),
         game.theme.baseColor.opacity(0.2),
         game.theme.baseColor.opacity(0.4),
         game.theme.baseColor.opacity(0.4),
         game.theme.baseColor.opacity(0.5),
        ]
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




#Preview {
    EmojiMemoryGameView(game: EmojiMemoryGame())
}
