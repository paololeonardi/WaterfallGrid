//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI
import WaterfallGrid

struct RectanglesGrid: View {
    @Binding var rectangles: [RectangleModel]
    @Binding var settings: Settings

    var body: some View {
        let scrollDirection: Axis.Set = settings.scrollDirection == .vertical ? .vertical : .horizontal

        #if os(iOS) && !targetEnvironment(macCatalyst)

        return
            ScrollView(scrollDirection, showsIndicators: settings.showsIndicators) {
                WaterfallGrid(rectangles) { rectangle in
                    RectangleView(rectangle: rectangle, scrollDirection: scrollDirection)
                }
                .gridStyle(
                    columnsInPortrait: Int(settings.columnsInPortrait),
                    columnsInLandscape: Int(settings.columnsInLandscape),
                    spacing: CGFloat(settings.spacing),
                    animation: settings.animation
                )
                .scrollOptions(direction: scrollDirection)
                .padding(settings.padding)
            }

        #else

        return
            ScrollView(scrollDirection, showsIndicators: settings.showsIndicators) {
                WaterfallGrid(rectangles) { rectangle in
                    RectangleView(rectangle: rectangle, scrollDirection: scrollDirection)
                }
                .gridStyle(
                    columns: Int(settings.columns),
                    spacing: CGFloat(settings.spacing),
                    animation: settings.animation
                )
                .scrollOptions(direction: scrollDirection)
                .padding(settings.padding)
            }
        
        #endif
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @State static var rectangles: [RectangleModel] = []
    @State static var settings: Settings = Settings.default(for: .rectangles(.addRemove))
    
    static var previews: some View {
        RectanglesGrid(rectangles: $rectangles, settings: $settings)
    }
}
