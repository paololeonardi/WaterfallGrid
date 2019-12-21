//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

// MARK: - ScrollOptions

extension View {

    /// Sets the scroll options for `WaterfallGrid` within the environment of `self`.
    ///
    /// - Parameters:
    ///   - direction: The scrollable axes. The default is `.vertical`.
    ///   - showsIndicators: Whether to show the scroll indicators. The default is `true`.
    public func scrollOptions(direction: Axis.Set = .vertical, showsIndicators: Bool = true) -> some View {
        let options = ScrollOptions(direction: direction, showsIndicators: showsIndicators)
        return self.environment(\.scrollOptions, options)
    }

}
