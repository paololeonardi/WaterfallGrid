//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

/// A container that presents items of variable heights arranged in a grid.
@available(iOS 13, OSX 10.15, tvOS 13, watchOS 6, *)
public struct WaterfallGrid<Data, ID, Content>: View where Data : RandomAccessCollection, Content : View, ID : Hashable {

    @Environment(\.gridStyle) private var style

    private let data: Data
    private let dataId: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content

    @State private var loaded = false

    @State private var alignmentGuides = [AnyHashable: CGPoint]() {
        didSet { loaded = !oldValue.isEmpty }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.grid(in: geometry)
        }
    }

    private func grid(in geometry: GeometryProxy) -> some View {
        let columnWidth = self.columnWidth(columns: style.columns, spacing: style.spacing, padding: style.padding,
                                           scrollDirection: style.scrollDirection, geometrySize: geometry.size)
        return ScrollView(style.scrollDirection) {
            ZStack(alignment: .topLeading) {
                ForEach(data, id: self.dataId) { element in
                    self.content(element)
                        .frame(width: self.style.scrollDirection == .vertical ? columnWidth : nil,
                               height: self.style.scrollDirection == .horizontal ? columnWidth : nil)
                        .background(PreferenceSetter(id: element[keyPath: self.dataId]))
                        .alignmentGuide(.top, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.y ?? 0 })
                        .alignmentGuide(.leading, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.x ?? 0 })
                        .opacity(self.alignmentGuides[element[keyPath: self.dataId]] != nil ? 1 : 0)
                        .animation(self.loaded ? self.style.animation : nil)
                }
            }
            .padding(style.padding)
            .onPreferenceChange(ElementPreferenceKey.self, perform: { preferences in
                DispatchQueue.global(qos: .utility).async {
                    let alignmentGuides = self.calculateAlignmentGuides(columns: self.style.columns, spacing: self.style.spacing,
                                                                        scrollDirection: self.style.scrollDirection, preferences: preferences)
                    DispatchQueue.main.async {
                        self.alignmentGuides = alignmentGuides
                    }
                }
            })
        }
    }

    // MARK: - Helpers

    func calculateAlignmentGuides(columns: Int, spacing: CGFloat, scrollDirection: Axis.Set, preferences: [ElementPreferenceData]) -> [AnyHashable: CGPoint] {
        var heights = Array(repeating: CGFloat(0), count: columns)
        var alignmentGuides = [AnyHashable: CGPoint]()

        preferences.forEach { preference in
            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
                let preferenceSizeWidth = scrollDirection == .vertical ? preference.size.width : preference.size.height
                let preferenceSizeHeight = scrollDirection == .vertical ? preference.size.height : preference.size.width
                let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
                let height = heights[indexMin]
                let offset = CGPoint(x: 0 - (scrollDirection == .vertical ? width : height),
                                     y: 0 - (scrollDirection == .vertical ? height : width))
                heights[indexMin] += preferenceSizeHeight + spacing
                alignmentGuides[preference.id] = offset
            }
        }

        return alignmentGuides
    }

    func columnWidth(columns: Int, spacing: CGFloat, padding: EdgeInsets, scrollDirection: Axis.Set, geometrySize: CGSize) -> CGFloat {
        let geometrySizeWidth = scrollDirection == .vertical ? geometrySize.width : geometrySize.height
        let padding = scrollDirection == .vertical ? padding.leading + padding.trailing : padding.top + padding.bottom
        let width = geometrySizeWidth - padding - (spacing * (CGFloat(columns) - 1))
        return width / CGFloat(columns)
    }
}

// MARK: - Initializers

extension WaterfallGrid {

    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = id
        self.content = content
    }

}

extension WaterfallGrid where ID == Data.Element.ID, Data.Element : Identifiable {

    /// Creates an instance that uniquely identifies views across updates based
    /// on the identity of the underlying data element.
    ///
    /// - Parameter data: A collection of identified data.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = \Data.Element.id
        self.content = content
    }

}

// MARK: - Style Setters

extension WaterfallGrid {

    /// Sets the style for `WaterfallGrid` within the environment of `self`.
    ///
    /// - Parameter columns: The number of columns of the grid. The default is `2`.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter padding: The custom distance that the content view is inset from the scroll view edges. The default is`0` for all edges.
    /// - Parameter scrollDirection: The scrollable axes. The default is `.vertical`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    public func gridStyle(
        columns: Int = 2,
        spacing: CGFloat = 8,
        padding: EdgeInsets = .init(),
        scrollDirection: Axis.Set = .vertical,
        animation: Animation? = .default
    ) -> some View {
        let style = GridSyle(
            columnsInPortrait: columns,
            columnsInLandscape: columns,
            spacing: spacing,
            padding: padding,
            scrollDirection: scrollDirection,
            animation: animation
        )
        return self.environment(\.gridStyle, style)
    }

    /// Sets the style for `WaterfallGrid` within the environment of `self`.
    ///
    /// - Parameter columnsInPortrait: The number of columns of the grid when the device is in a portrait orientation. The default is `2`.
    /// - Parameter columnsInLandscape: The number of columns of the grid when the device is in a landscape orientation The default is `2`.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter padding: The custom distance that the content view is inset from the scroll view edges. The default is`0` for all edges.
    /// - Parameter scrollDirection: The scrollable axes. The default is `.vertical`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func gridStyle(
        columnsInPortrait: Int = 2,
        columnsInLandscape: Int = 2,
        spacing: CGFloat = 8,
        padding: EdgeInsets = .init(),
        scrollDirection: Axis.Set = .vertical,
        animation: Animation? = .default
    ) -> some View {
        let style = GridSyle(
            columnsInPortrait: columnsInPortrait,
            columnsInLandscape: columnsInLandscape,
            spacing: spacing,
            padding: padding,
            scrollDirection: scrollDirection,
            animation: animation
        )
        return self.environment(\.gridStyle, style)
    }

}
