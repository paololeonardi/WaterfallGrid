//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct CardsContainer: View {
    
    @State private var cards: [Card] = Generator.Cards.random()
    @State private var settings: Settings = Settings.default(for: .cards)
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            CardsGrid(cards: $cards, settings: $settings)
                .customNavigationBarTitle(Text("WaterfallGrid"), displayMode: .inline)
                .customNavigationBarItems(leading: self.leadingNavigationBarItems(), trailing: self.trailingNavigationBarItems())
        }
        .sheet(isPresented: $showSettings, content: { SettingsView(settings: self.$settings, screen: .cards, isPresented: self.$showSettings) })
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func leadingNavigationBarItems() -> some View {
        Button(action: { self.showSettings = true }) {
            Image(systemName: "gear")
        }
    }
    
    private func trailingNavigationBarItems() -> some View {
        HStack() {
            Button(action: { self.cards = Generator.Cards.random() }) {
                Image(systemName: "gobackward")
            }
        }
    }
}

struct CardsContainer_Previews: PreviewProvider {
    static var previews: some View {
        CardsContainer()
    }
}
