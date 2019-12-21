//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation
import SwiftUI

struct Settings {
    var columnsInPortrait: Double
    var columnsInLandscape: Double
    var spacing: Double
    var padding: EdgeInsets
    var scrollDirection: Axis
    var showsIndicators: Bool
    var animation: Animation?
    var animationSpeed: Double
    
    var columns: Double {
        #if os(OSX) || os(tvOS) || targetEnvironment(macCatalyst)
        return columnsInLandscape
        #else
        return columnsInPortrait
        #endif
    }
    
    var animationEnabled: Bool {
        animation != nil
    }
    
    static func `default`(for screen: Screen, scrollDirection: Axis = .vertical) -> Settings {
        switch screen {

        case .rectangles:
            return Settings(
                columnsInPortrait: 4,
                columnsInLandscape: 5,
                spacing: 8,
                padding: .init(top: 8, leading: 8, bottom: 8, trailing: 8),
                scrollDirection: scrollDirection,
                showsIndicators: true,
                animation: .default,
                animationSpeed: 1
            )

        case .images:
            return Settings(
                columnsInPortrait: 2,
                columnsInLandscape: 4,
                spacing: 4,
                padding: .init(),
                scrollDirection: scrollDirection,
                showsIndicators: true,
                animation: .default,
                animationSpeed: 1
            )

        case .cards:
            return Settings(
                columnsInPortrait: 2,
                columnsInLandscape: 4,
                spacing: 8,
                padding: .init(top: 8, leading: 8, bottom: 8, trailing: 8),
                scrollDirection: scrollDirection,
                showsIndicators: true,
                animation: .default,
                animationSpeed: 1
            )
        }
        
    }
}
