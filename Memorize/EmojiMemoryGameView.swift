//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/12/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var game: EmojiMemoryGame
    

    var body: some View {
        ZStack{
                background
                VStack(spacing: 0) {
                    ScrollView{
                        cards
                    }
                    .scrollClipDisabled()
                    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
                   
                    Group{
                        header
                          
                        scoreButtonView
                        
                    }
                    .background(.ultraThickMaterial)
                    .offset(y: 25)
                }
                .foregroundStyle(game.theme.baseColor)
                .padding()
        }
    }
    
    private var background: some View {
        
        
        LinearGradient(colors: backgroundColors, startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
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
            
        }
        
    }
    
    let aspectRatio: CGFloat = 2/3
    private var cards: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(3)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)){
                        game.choose(card)
                        
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
    
    
    private var scoreButtonView: some View {
        VStack {
            HStack{
                HStack{
                    Text("Score: ")
                    Spacer()
                    Text("\(game.score)")
                        .animation(nil)
                        .padding(.trailing, 10)
                }
                .font(.title)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(game.theme.baseColor.opacity(0.75))
                .cornerRadius(10)
                
                Button("Start a new game!") {
                    withAnimation {
                        game.startNewGame()
                    }
                    
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
