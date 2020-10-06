//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI
import WaterfallGrid

struct ImagesGrid: View {
    
    @Binding var images: [String]
    @Binding var settings: Settings
    
    var body: some View {
        let scrollDirection: Axis.Set = settings.scrollDirection == .vertical ? .vertical : .horizontal

        #if os(iOS) && !targetEnvironment(macCatalyst)

        return
            ScrollView(scrollDirection, showsIndicators: settings.showsIndicators) {
                WaterfallGrid((images), id: \.self) { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
                WaterfallGrid((images), id: \.self) { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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

struct ImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGrid(images: .constant(Generator.Images.random()), settings: .constant(Settings.default(for: .images)))
    }
}
