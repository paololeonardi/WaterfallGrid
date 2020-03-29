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
            RectanglesContainer(editMode: .addRemove)
                .tabItem {
                    Image(systemName: "rectangle.3.offgrid.fill")
                    Text("Add / Remove")
            }.tag(0)
            RectanglesContainer(editMode: .swapResize)
                .tabItem {
                    Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                    Text("Swap / Resize")
            }.tag(1)
            ImagesContainer()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Images")
            }.tag(2)
            CardsContainer()
                .tabItem {
                    Image(systemName: "doc.richtext")
                    Text("Cards")
            }.tag(3)
        }

    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
