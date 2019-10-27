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
    var animation: Animation?
    var animationSpeed: Double
    var spacing: Double
    var vPadding: Double
    var hPadding: Double
    
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
    
    static func `default`(for screen: Screen) -> Settings {
        switch screen {
        case .rectangles:
            return Settings(columnsInPortrait: 4, columnsInLandscape: 5, animation: .default, animationSpeed: 1, spacing: 8, vPadding: 8, hPadding: 8)
        case .images:
            return Settings(columnsInPortrait: 2, columnsInLandscape: 4, animation: .default, animationSpeed: 1, spacing: 4, vPadding: 0, hPadding: 0)
        case .cards:
            return Settings(columnsInPortrait: 2, columnsInLandscape: 4, animation: .default, animationSpeed: 1, spacing: 8, vPadding: 8, hPadding: 8)
        }
    }
}
