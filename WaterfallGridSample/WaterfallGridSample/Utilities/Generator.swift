//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation
import SwiftUI

struct Generator {
    
    struct Rectangles {
        static func random(editMode: EditMode) -> [RectangleModel] {
            Array(0..<60).map {
                let color = editMode == .swapResize ? disabledColor() : randomColor()
                return RectangleModel(index: $0, size: randomSize(), color: color)
            }
        }
        
        static func randomSize() -> CGFloat { CGFloat.random(in: 30...120) }

        static func fixedSize() -> CGFloat { 60 }
        
        static func randomColor() -> Color { [.red, .green, .blue, .orange, .yellow, .pink, .purple].randomElement()! }
        
        static func disabledColor() -> Color { .gray }
    }
    
    struct Images {
        static func random() -> [String] {
            Array(0..<22).map { "image\($0)" }.shuffled()
        }
    }
    
    struct Cards {
        static func random() -> [Card] {
            Images.random().map { Card(image: $0, title: LoremIpsum.randomTitle(), subtitle: LoremIpsum.randomSentences()) }
        }
    }
    
}
