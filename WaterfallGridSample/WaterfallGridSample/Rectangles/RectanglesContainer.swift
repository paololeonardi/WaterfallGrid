//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct RectanglesContainer: View {
    
    @State private var rectangles: [RectangleModel]
    @State private var settings: Settings
    @State private var showSettings = false
    @State private var rectanglesSameHeight = false
    
    private let editMode: EditMode
    
    init(editMode: EditMode) {
        self.editMode = editMode
        self._rectangles = State(initialValue: Generator.Rectangles.random(editMode: editMode))
        self._settings = State(initialValue: Settings.default(for: .rectangles(editMode)))
    }
    
    var body: some View {
        NavigationView {
            RectanglesGrid(rectangles: $rectangles, settings: $settings)
                .customNavigationBarTitle(Text("WaterfallGrid"), displayMode: .inline)
                .customNavigationBarItems(leading: self.leadingNavigationBarItems(), trailing: self.trailingNavigationBarItems())
        }
        .sheet(isPresented: $showSettings, content: { SettingsView(settings: self.$settings, screen: .rectangles(self.editMode), isPresented: self.$showSettings) })
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func leadingNavigationBarItems() -> some View {
        HStack(alignment: .bottom) {
            Button(action: { self.showSettings = true }) {
                Image(systemName: "gear")
            }
            Spacer(minLength: 20)
            Button(action: self.toggleRectanglesHeight) {
                if rectanglesSameHeight {
                    Image(systemName: "rectangle.grid.2x2")
                } else {
                    Image(systemName: "rectangle.3.offgrid")
                }
            }
        }
    }
    
    private func trailingNavigationBarItems() -> some View {
        switch editMode {
            
        case .addRemove:
            return HStack() {
                Button(action: self.addNewRectangle) {
                    Image(systemName: "rectangle.stack.badge.plus")
                }
                Spacer(minLength: 20)
                Button(action: self.removeFirstRectangle) {
                    Image(systemName: "rectangle.stack.badge.minus")
                }
            }
            
        case .swapResize:
            return HStack() {
                Button(action: self.swapRandomRectangles) {
                    Image(systemName: "arrow.swap")
                }
                Spacer(minLength: 20)
                Button(action: self.resizeRandomRectangle) {
                    Image(systemName: "rectangle.expand.vertical")
                }
            }
        }
    }
    
    // MARK: Actions
    
    private func addNewRectangle() {
        incrementIndexes(by: 1)
        let height = rectanglesSameHeight ? Generator.Rectangles.fixedHeight() : Generator.Rectangles.randomHeight()
        rectangles.insert(RectangleModel(index: 0, height: height), at: 0)
    }
    
    private func removeFirstRectangle() {
        guard rectangles.count > 0 else { return }
        rectangles.removeFirst()
        incrementIndexes(by: -1)
    }
    
    private func incrementIndexes(by value: Int) {
        rectangles = rectangles.map {
            var rectangle = $0
            rectangle.index += value
            return rectangle
        }
    }
    
    private func swapRandomRectangles() {
        let fromIndex = Int.random(in: 0..<rectangles.count / 3)
        let toIndex = Int.random(in: 0..<rectangles.count / 3)
        let newFromElement = RectangleModel(id: rectangles[toIndex].id, index: fromIndex, height: rectangles[toIndex].height)
        let newToElement = RectangleModel(id: rectangles[fromIndex].id, index: toIndex, height: rectangles[fromIndex].height)
        rectangles = rectangles.enumerated().map {
            if $0.offset == fromIndex {
                return newFromElement
            } else if $0.offset == toIndex {
                return newToElement
            } else {
                var element = $0.element
                element.color = Generator.Rectangles.disabledColor()
                return element
            }
        }
    }
    
    private func resizeRandomRectangle() {
        let randomIndex = Int.random(in: 0..<rectangles.count / 3)
        rectangles = rectangles.enumerated().map {
            if $0.offset == randomIndex {
                return RectangleModel(id: $0.element.id, index: $0.element.index)
            } else {
                var element = $0.element
                element.color = Generator.Rectangles.disabledColor()
                return element
            }
        }
        rectanglesSameHeight = false
    }
    
    private func toggleRectanglesHeight() {
        if rectanglesSameHeight {
            rectangles = rectangles.map {
                var rectangle = $0
                rectangle.height = Generator.Rectangles.randomHeight()
                return rectangle
            }
        } else {
            rectangles = rectangles.map {
                var rectangle = $0
                rectangle.height = Generator.Rectangles.fixedHeight()
                return rectangle
            }
        }
        rectanglesSameHeight.toggle()
    }
}

struct RectanglesGrid_Previews: PreviewProvider {
    static var previews: some View {
        RectanglesContainer(editMode: .addRemove)
    }
}
