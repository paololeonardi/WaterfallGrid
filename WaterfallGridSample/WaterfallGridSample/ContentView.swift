//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        #if os(watchOS)
        
        return List() {
            NavigationLink(destination: RectanglesGrid(rectangles: .constant(Generator.Rectangles.random(editMode: .addRemove)),
                                                       settings: .constant(Settings.default(for: .rectangles(.addRemove))))
            ) {
                Text("Rectangles")
            }
            NavigationLink(destination: ImagesGrid(images: .constant(Generator.Images.random()),
                                                   settings: .constant(Settings.default(for: .images)))
            ) {
                Text("Images")
            }
        }
        
        #elseif os(OSX)
        
        return TabView(selection: $selectedTab) {
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
        
        #else
        
        return TabView(selection: $selectedTab) {
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
        }.edgesIgnoringSafeArea(.top)
        
        #endif
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
