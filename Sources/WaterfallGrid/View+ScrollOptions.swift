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
    public func scrollOptions(direction: Axis.Set) -> some View {
        let options = ScrollOptions(direction: direction)
        return self.environment(\.scrollOptions, options)
    }

}
