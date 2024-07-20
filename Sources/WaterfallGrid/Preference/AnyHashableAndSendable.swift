//
//  Copyright © 2024 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation

struct AnyHashableAndSendable: @unchecked Sendable, Hashable {
    private let wrapped: AnyHashable

    init(_ wrapped: some Hashable & Sendable) {
        self.wrapped = .init(wrapped)
    }
}
