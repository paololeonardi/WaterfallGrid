//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct GridSyle {
    @PositiveNumber var columnsInPortrait: Int
    @PositiveNumber var columnsInLandscape: Int

    let spacing: CGFloat
    let padding: EdgeInsets
    let scrollDirection: Axis.Set
    let animation: Animation?

    var columns: Int {
        #if os(OSX) || os(tvOS) || targetEnvironment(macCatalyst)
        return columnsInLandscape
        #elseif os(watchOS)
        return columnsInPortrait
        #else
        return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height ? columnsInLandscape : columnsInPortrait
        #endif
    }
}

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: GridSyle = GridSyle(columnsInPortrait: 2, columnsInLandscape: 2, spacing: 8,
                                                 padding: .init(), scrollDirection: .vertical, animation: .default)
}

extension EnvironmentValues {
    var gridStyle: GridSyle {
        get {
            return self[GridStyleKey.self]
        }
        set {
            self[GridStyleKey.self] = newValue
        }
    }
}
