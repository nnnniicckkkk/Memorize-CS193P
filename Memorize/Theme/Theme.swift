//
//  Theme.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/16/24.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairsOfCards: Int?
    var baseColor: Color
}
let themes: [Theme] = [
    
    //due to the way the viewModel is set up, there needs to be at least 10 options to choose from
    // TODO: change index to a min/max set up??
    
    
    Theme(name: "Fall",
        emojis: ["🍁","🍂","🎃","🍫","🧙‍♀️","💀","☠️","🌝","👻","👽","🤖"],
        baseColor: Color.orange),
    Theme(name: "Summer",
        emojis: ["🔥","⛺️","🌊","🎣","🧨","☀️","🏄","🍖","🌭","🔭", "🌞"],
        baseColor: Color.yellow),
    Theme(name: "Winter",
          emojis: ["🧤","🌨️","☃️","⛄️","☕️","🥶","🎅", "🧣","🐻‍❄️", "🤶", "🥌"],
        baseColor: Color.blue)
    


]
