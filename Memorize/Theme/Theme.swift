//
//  Theme.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/16/24.
//

import Foundation
import SwiftUI

/// A theme for the emoji memory game
struct Theme {
    
    /// The name of the theme
    var name: String
    /// The emojis for the theme
    var emojis: [String]
    /// The number of pairs of cards to use in the game, if nil a random number is used
    var numberOfPairsOfCards: Int?
    /// The base color of the theme
    var baseColor: Color
}

/// An array of themes for the emoji memory game. 
let themes: [Theme] = [
    
    Theme(name: "Fall",
        emojis: ["🍁","🍂","🎃","🍫","🧙‍♀️","💀","☠️","🌝","👻","👽","🤖"],
        baseColor: Color.orange),
    Theme(name: "Summer",
        emojis: ["🔥","⛺️","🌊","🎣","🧨","☀️","🏄","🍖","🌭","🔭", "🌞"],
          baseColor: Color.yellow),
    Theme(name: "Winter",
          emojis: ["🧤","🌨️","☃️","⛄️","☕️","🥶","🎅", "🧣","🐻‍❄️", "🤶", "🥌"],
          baseColor: Color.blue),
    Theme(name: "Spring",
        emojis: ["🌸", "🌼", "🌷", "🌱", "🌿", "🌺", "🦋", "🌞", "🐝", "🌻", "🍃", "🌈", "🌱", "☔️", "🌦"],
          baseColor: Color.green),
    Theme(name: "Beach",
        emojis: ["🏖️", "🌊", "🏄‍♂️", "🐚", "🦀", "🐠", "🏝️", "👙", "🍹", "🌞"],
        baseColor: Color.brown.opacity(0.5)),
    Theme(name: "Food",
          emojis: ["🍔", "🍕", "🌮", "🍣", "🥗", "🍝", "🍰", "🍩", "🍦", "🍪"],
          baseColor: Color.red),
    Theme(name: "Purple",
          emojis: ["💜", "🔮", "☂️", "🦄", "👾", "🍇", "🎵", "👚", "🦉", "🌌"],
          baseColor: Color.purple),
    Theme(name: "Rainbow",
          emojis: ["🌈", "🦄", "🎨", "🍭", "🌺", "🎈", "🔮", "🌞", "🌼", "🎵"],
          baseColor: Color.indigo
            
         )
    
]

