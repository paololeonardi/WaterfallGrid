//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack() {
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .layoutPriority(97)

            HStack() {
                VStack(alignment: .leading) {
                    Text(card.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(98)
                    Text(card.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(99)
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom], 8)
        }
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary.opacity(0.5))
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(image: "image0", title: "Title", subtitle: "Subtitle"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
