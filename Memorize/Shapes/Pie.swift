//
//  Pie.swift
//  Memorize
//
//  Created by Nicholas Hurst on 5/3/24.
//

import SwiftUI
import CoreGraphics


/// A shape that represents a pie slice.
///
/// Use a `Pie` shape to create a pie slice with a specified start angle, end angle, and direction.
///
/// Example:
/// ```swift
/// Pie(startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)
///     .foregroundColor(.blue)
/// ```
///
struct Pie: Shape {
    /// The starting angle of the pie slice
    var startAngle: Angle = .zero
    /// The ending angle of the pie slice.
    let endAngle: Angle
    /// A boolean value indicating if the pie slice is drawn clockwise.
    var clockwise = true
    
    /// Creates a pie slice shape.
        /// - Parameters:
        ///   - startAngle: The starting angle of the pie slice. Defaults to `.zero`.
        ///   - endAngle: The ending angle of the pie slice.
        ///   - clockwise: A boolean value indicating whether the pie slice is drawn clockwise. Defaults to `true`.
    func path(in rect: CGRect) -> Path {
        /// Returns a path that represents the pie slice.
          /// - Parameter rect: The bounding rectangle of the pie slice.
          /// - Returns: A path that represents the pie slice.
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
    
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
                x: center.x + radius * cos(startAngle.radians),
                y: center.y + radius * sin(startAngle.radians)
            )
                
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: !clockwise
        )
        p.addLine(to: center)

        return p
    }
    
    
}
