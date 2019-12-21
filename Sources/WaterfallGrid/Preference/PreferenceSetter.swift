//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct PreferenceSetter<ID: Hashable>: View {
    var id: ID
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ElementPreferenceKey.self, value: [ElementPreferenceData(id: AnyHashable(self.id), size: geometry.size)])
        }
    }
}
