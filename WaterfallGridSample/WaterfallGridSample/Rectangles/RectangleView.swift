//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct RectangleView: View {
    let rectangle: RectangleModel
    let scrollDirection: Axis.Set
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(rectangle.color)
                .frame(width: scrollDirection == .horizontal ? rectangle.size : nil, height: scrollDirection == .vertical ? rectangle.size : nil)
                .cornerRadius(8)
            Text("\(rectangle.index)")
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }
    }
}

struct RoundRectangle_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(rectangle: RectangleModel(index: 1, size: 100, color: .red), scrollDirection: .vertical)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
