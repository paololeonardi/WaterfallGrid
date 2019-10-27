//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation
import SwiftUI

struct RectangleModel: Identifiable, Equatable {
    var id = UUID()
    var index: Int
    var height: CGFloat = Generator.Rectangles.randomHeight()
    var color: Color = Generator.Rectangles.randomColor()
}
