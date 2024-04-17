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
        ZStack{
            //background
            background
        
            //foreground
            ZStack {
                VStack(spacing: 0) {
                    header
                    
                    ScrollView {
                        cards
                            .animation(.default, value: game.cards)
                        
                    }
                    .padding()
              
                    scoreButtonView
                        
                }
            }
            .foregroundStyle(game.theme.baseColor)
            .padding()
        }
    }
    
    var background: some View {
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
    var header: some View {
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
    
    var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: game.cards.count, size: geometry.size, atAspectRatio: 1)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: (gridItemSize * 7) + 2.5), spacing: 0)],spacing: 0) {
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
    
//    // TODO: figure out why this code does not produce gridItems
//    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
//        let count = CGFloat(count)
//        var columnCount = 1.0
//        repeat {
//            let width = size.width / columnCount
//            let height = width / aspectRatio
//            
//            let rowCount = (count / columnCount).rounded(.up)
//            if rowCount * height < size.height {
//                return (size.width / columnCount).rounded(.down)
//            }
//            columnCount += 1
//        } while columnCount < count
//        print(min(size.width / count, size.height * aspectRatio).rounded(.down))
//        return min(size.width / count, size.height * aspectRatio).rounded(.down)
//        
//        
//    }
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let totalWidth = size.width
        let totalHeight = size.height
        let itemAspectRatio = aspectRatio

        // Calculate the number of columns needed to fit all cards
        var columns = 1
        while CGFloat(columns) * itemAspectRatio * totalHeight <= totalWidth {
            columns += 1
        }

        // Adjust for the extra column created by the loop
        columns -= 1

        // Calculate the width of each item based on the number of columns
        let itemWidth = totalWidth / CGFloat(columns)

        return itemWidth
    }

    
    var scoreButtonView: some View {
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
