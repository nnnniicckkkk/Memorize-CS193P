//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Nicholas Hurst on 5/3/24.
//

import SwiftUI

struct FlyingNumber: View {
    
    let number: Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
