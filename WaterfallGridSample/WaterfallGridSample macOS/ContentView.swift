//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {

        TabView(selection: $selectedTab) {
            RectanglesGrid(rectangles: .constant(Generator.Rectangles.random(editMode: .addRemove)),
                           settings: .constant(Settings.default(for: .rectangles(.addRemove))))
                .tabItem {
                    Text("Rectangles")
            }.tag(0)
            ImagesGrid(images: .constant(Generator.Images.random()), settings: .constant(Settings.default(for: .images)))
                .tabItem {
                    Text("Images")
            }.tag(1)
            CardsGrid(cards: .constant(Generator.Cards.random()), settings: .constant(Settings.default(for: .cards)))
                .tabItem {
                    Text("Cards")
            }.tag(2)
        }
        
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
