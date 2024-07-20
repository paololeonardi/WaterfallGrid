//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct ElementPreferenceData: Equatable, Sendable {
    let id: AnyHashableAndSendable
    let size: CGSize
}

struct ElementPreferenceKey: PreferenceKey {
    typealias Value = [ElementPreferenceData]

    static let defaultValue: [ElementPreferenceData] = []

    static func reduce(value: inout [ElementPreferenceData], nextValue: () -> [ElementPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
