//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct SettingsView: View {
    
    private var settings: Binding<Settings>
    private var isPresented: Binding<Bool>
    private let screen: Screen
    
    @State private var newSettings: Settings
    @State private var animationEnabled: Bool
    
    init(settings: Binding<Settings>, screen: Screen, isPresented: Binding<Bool>) {
        self.settings = settings
        self.screen = screen
        self.isPresented = isPresented
        self._newSettings = State(initialValue: settings.wrappedValue)
        self._animationEnabled = State(initialValue: settings.wrappedValue.animationEnabled)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                Form() {
                    Section(header: Text("Columns")) {
                        #if os(iOS) && !targetEnvironment(macCatalyst)
                        self.valueSelector(self.$newSettings.columnsInPortrait, bounds: 1...10, step: 1, label: "Portrait", in: geometry)
                        self.valueSelector(self.$newSettings.columnsInLandscape, bounds: 1...10, step: 1, label: "Landscape", in: geometry)
                        #else
                        self.valueSelector(self.$newSettings.columnsInLandscape, bounds: 1...10, step: 1, label: "Columns", in: geometry)
                        #endif
                    }

                    Section(header: Text("Spacing")) {
                        self.valueSelector(self.$newSettings.spacing, bounds: 0...40, step: 1, label: "Spacing", in: geometry)
                    }

                    Section(header: Text("Padding")) {
                        self.valueSelector(self.$newSettings.padding.top, bounds: 0...40, step: 1, label: "Top", in: geometry)
                        self.valueSelector(self.$newSettings.padding.leading, bounds: 0...40, step: 1, label: "Leading", in: geometry)
                        self.valueSelector(self.$newSettings.padding.bottom, bounds: 0...40, step: 1, label: "Bottom", in: geometry)
                        self.valueSelector(self.$newSettings.padding.trailing, bounds: 0...40, step: 1, label: "Trailing", in: geometry)
                    }

                    Section(header: Text("Scroll Options")) {
                        Picker(selection: self.$newSettings.scrollDirection, label: Text("Direction")) {
                            ForEach(Axis.allCases, id: \.self) { axes in
                                Text(axes.description.capitalized)
                            }
                        }
                        Toggle(isOn: self.$newSettings.showsIndicators) {
                            Text("Show Indicators")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Section(header: Text("Animation")) {
                        Toggle(isOn: self.$animationEnabled) {
                            Text("Enabled")
                        }
                        if self.animationEnabled {
                            self.valueSelector(self.$newSettings.animationSpeed, bounds: 0.1...1, step: 0.05, label: "Speed", in: geometry)
                        }
                    }
                }
                .onDisappear {
                    let animation = Animation.default.speed(self.newSettings.animationSpeed)
                    self.newSettings.animation = self.animationEnabled ? animation : nil
                    self.settings.wrappedValue = self.newSettings
                }
                .customNavigationBarTitle(Text("Settings"), displayMode: .inline)
                .customNavigationBarItems(leading: self.leadingNavigationBarItems(), trailing: self.trailingNavigationBarItems())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func valueSelector<V>(_ selection: Binding<V>, bounds: ClosedRange<V>, step: V.Stride, label: String, in geometry: GeometryProxy) -> some View
        where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
            #if os(tvOS)
            return Picker(selection: selection, label: Text(label)) {
                ForEach(Array(stride(from: bounds.lowerBound, through: bounds.upperBound, by: step)), id: \.self) { index in
                    Text(String(format:"%.2f", Double(index)))
                }
            }
            #else
            return HStack() {
                Text("\(label): \(String(format:"%.2f", Double(selection.wrappedValue)))")
                Spacer()
                Slider(value: selection, in: bounds, step: step)
                    .frame(width: geometry.size.width / 2)
            }
            #endif
    }
    
    private func leadingNavigationBarItems() -> some View {
        Button(action: {
            let defaultSettings = Settings.default(for: self.screen)
            self.animationEnabled = defaultSettings.animationEnabled
            self.newSettings = defaultSettings
        }) {
            Text("Reset")
        }
    }
    
    private func trailingNavigationBarItems() -> some View {
        Button(action: { self.isPresented.wrappedValue = false }) {
            Text("Done")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var settings: Settings = Settings(columnsInPortrait: 2, columnsInLandscape: 5, spacing: 8,
                                                    padding: .init(), scrollDirection: .vertical,
                                                    showsIndicators: true, animation: .default, animationSpeed: 1)
    
    static var previews: some View {
        SettingsView(settings: $settings, screen: .images, isPresented: .constant(true))
    }
}
