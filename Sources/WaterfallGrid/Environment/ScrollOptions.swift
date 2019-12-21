//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct ScrollOptions {
    let direction: Axis.Set
    let showsIndicators: Bool
}

struct ScrollOptionsKey: EnvironmentKey {
    static let defaultValue = ScrollOptions(direction: .vertical, showsIndicators: true)
}

extension EnvironmentValues {
    var scrollOptions: ScrollOptions {
        get { self[ScrollOptionsKey.self] }
        set { self[ScrollOptionsKey.self] = newValue }
    }
}
