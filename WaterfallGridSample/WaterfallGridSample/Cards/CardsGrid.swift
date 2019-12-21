//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI
import WaterfallGrid

struct CardsGrid: View {
    
    @Binding var cards: [Card]
    @Binding var settings: Settings
    
    var body: some View {
        
        #if os(iOS) && !targetEnvironment(macCatalyst)

        return WaterfallGrid((0..<cards.count), id: \.self) { index in
            CardView(card: self.cards[index])
        }
        .gridStyle(
            columnsInPortrait: Int(settings.columnsInPortrait),
            columnsInLandscape: Int(settings.columnsInLandscape),
            spacing: CGFloat(settings.spacing),
            padding: settings.padding,
            animation: settings.animation
        )
        .scrollOptions(showsIndicators: settings.showsIndicators)
        
        #else

        return WaterfallGrid((0..<cards.count), id: \.self) { index in
            CardView(card: self.cards[index])
        }
        .gridStyle(
            columns: Int(settings.columns),
            spacing: CGFloat(settings.spacing),
            padding: settings.padding,
            animation: settings.animation
        )
        .scrollOptions(showsIndicators: settings.showsIndicators)

        #endif

    }
}

struct CardsGrid_Previews: PreviewProvider {
    static let cards = [
        Card(image: "image0", title: LoremIpsum.randomTitle(), subtitle: LoremIpsum.randomSentences()),
        Card(image: "image1", title: LoremIpsum.randomTitle(), subtitle: LoremIpsum.randomSentences())
    ]
    static let settings: Settings = Settings.default(for: .images)
    
    static var previews: some View {
        CardsGrid(cards: .constant(cards), settings: .constant(settings))
    }
}
