//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Nicholas Hurst on 4/17/24.
//



import SwiftUI

/// A grid that arranges its items with a specified aspect ratio.
///
/// Use an `AspectVGrid` to arrange items in a grid layout where each item maintains a specified aspect ratio.
/// You provide the items to be displayed, the aspect ratio for each item, and a closure that creates a view for each item.
///
/// Example:
/// ```swift
/// AspectVGrid(items: items, aspectRatio: 1.5) { item in
///     Image(item.imageName)
///         .resizable()
///         .aspectRatio(contentMode: .fill)
/// }
/// ```
///
/// - Parameters:
///   - items: An array of items to be displayed in the grid.
///   - aspectRatio: The aspect ratio to maintain for each item.
///   - content: A closure that returns the view to be displayed for each item.
struct AspectVGrid<Item: Identifiable, ItemView: View>: View  {
    
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: items.count, size: geometry.size, atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
 
    /// Calculates the width of a grid item that fits the specified aspect ratio.
    /// - Parameters:
    ///   - count: The number of items in the grid.
    ///   - size: The size of the grid.
    ///   - aspectRatio: The aspect ratio to maintain for each item.
    /// - Returns: The width of a grid item that fits the specified aspect ratio.
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                
                print((size.width / columnCount).rounded(.down))
                return((size.width / columnCount).rounded(.down) * 12)
            }
            columnCount += 1
        } while columnCount < count
        
        print(min(size.width / count, size.height * aspectRatio).rounded(.down))
        return (min(size.width / count, size.height * aspectRatio).rounded(.up) * 12)
        
        
    }
    
  
}

