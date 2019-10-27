//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct RectangleView: View {
    let rectangle: RectangleModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(rectangle.color)
                .frame(height: rectangle.height)
                .cornerRadius(8)
            Text("\(rectangle.index)")
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }
    }
}

struct RoundRectangle_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(rectangle: RectangleModel(index: 1, height: 100, color: .red))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
