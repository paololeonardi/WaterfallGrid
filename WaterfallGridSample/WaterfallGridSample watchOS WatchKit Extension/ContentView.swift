//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {

        List() {
            NavigationLink(destination: RectanglesGrid(rectangles: .constant(Generator.Rectangles.random(editMode: .addRemove)),
                                                       settings: .constant(Settings.default(for: .rectangles(.addRemove))))
            ) {
                Text("Rectangles \n[vertical scroll]")
            }
            NavigationLink(destination: RectanglesGrid(rectangles: .constant(Generator.Rectangles.random(editMode: .addRemove)),
                                                       settings: .constant(Settings.default(for: .rectangles(.addRemove), scrollDirection: .horizontal)))
            ) {
                Text("Rectangles \n[horizontal scroll]")
            }
            NavigationLink(destination: ImagesGrid(images: .constant(Generator.Images.random()),
                                                   settings: .constant(Settings.default(for: .images)))
            ) {
                Text("Images \n[vertical scroll]")
            }
            NavigationLink(destination: ImagesGrid(images: .constant(Generator.Images.random()),
                                                   settings: .constant(Settings.default(for: .images, scrollDirection: .horizontal)))
            ) {
                Text("Images \n[horizontal scroll]")
            }
        }

    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
