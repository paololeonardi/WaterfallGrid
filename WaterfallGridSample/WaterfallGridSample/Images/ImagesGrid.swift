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
        #if os(iOS) && !targetEnvironment(macCatalyst)
        return WaterfallGrid((images),
                             id: \.self,
                             columnsInPortrait: Int(settings.columnsInPortrait),
                             columnsInLandscape: Int(settings.columnsInLandscape),
                             spacing: CGFloat(settings.spacing),
                             vPadding: CGFloat(settings.vPadding),
                             hPadding: CGFloat(settings.hPadding),
                             animation: settings.animation
        ) { image in
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        #else
        return WaterfallGrid((images),
                             id: \.self,
                             columns: Int(settings.columns),
                             spacing: CGFloat(settings.spacing),
                             vPadding: CGFloat(settings.vPadding),
                             hPadding: CGFloat(settings.hPadding),
                             animation: settings.animation
        ) { image in
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        #endif
    }
}

struct ImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGrid(images: .constant(Generator.Images.random()), settings: .constant(Settings.default(for: .images)))
    }
}
