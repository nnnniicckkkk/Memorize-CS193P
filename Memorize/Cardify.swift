//
//  Cardify.swift
//  Memorize
//
//  Created by Nicholas Hurst on 5/3/24.
//

import SwiftUI

/// A View Modifier for displaying a card with a border and optional content.
struct Cardify: ViewModifier, Animatable {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    /// A boolean value indicating if the card is face up or face down
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    /// Modifies the view to display a card with a border and optional content.
    /// - Parameter content: The content to be displayed on the card.
    /// - Returns: A view display the card with the specified content.
    func body(content: Content) -> some View {
        
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    /// Constants used in the view modifier
    private struct Constants {
        /// The corner radius of the card
        static let cornerRadius: CGFloat = 12
        /// The width of the border line of the card
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    /// Adds the 'Cardify' view modifier to the view, displaying as a card.
    /// - Parameter isFaceUp: A boolean value indicating whether or not the card is face up
    /// - Returns: A view modified to display as a card. 
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
