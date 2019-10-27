//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

/// A container that presents items of variable heights arranged in a grid.
@available(iOS 13, OSX 10.15, tvOS 13, watchOS 6, *)
public struct WaterfallGrid<Data, ID, Content>: View where Data : RandomAccessCollection, Content : View, ID : Hashable {

    private let data: Data
    private let dataId: KeyPath<Data.Element, ID>
    @PositiveNumber private var columnsInPortrait: Int
    @PositiveNumber private var columnsInLandscape: Int
    private let spacing: CGFloat
    private let vPadding: CGFloat
    private let hPadding: CGFloat
    private let animation: Animation?
    private let content: (Data.Element) -> Content

    private var columns: Int {
        #if os(OSX) || os(tvOS) || targetEnvironment(macCatalyst)
        return columnsInLandscape
        #elseif os(watchOS)
        return columnsInPortrait
        #else
        return UIDevice.current.orientation.isLandscape ? columnsInLandscape : columnsInPortrait
        #endif
    }

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
        let columnWidth = self.columnWidth(columns: columns, spacing: spacing, hPadding: hPadding, geometrySize: geometry.size)
        return ScrollView() {
            ZStack(alignment: .topLeading) {
                ForEach(data, id: self.dataId) { element in
                    self.content(element)
                        .frame(width: columnWidth)
                        .background(PreferenceSetter(id: element[keyPath: self.dataId]))
                        .alignmentGuide(.top, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.y ?? 0 })
                        .alignmentGuide(.leading, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.x ?? 0 })
                        .opacity(self.alignmentGuides[element[keyPath: self.dataId]] != nil ? 1 : 0)
                        .animation(self.loaded ? self.animation : nil)
                }
            }
            .padding(.vertical, vPadding)
            .padding(.horizontal, hPadding)
            .onPreferenceChange(ElementPreferenceKey.self, perform: { preferences in
                DispatchQueue.global(qos: .utility).async {
                    let alignmentGuides = self.calculateAlignmentGuides(columns: self.columns, spacing: self.spacing, preferences: preferences)
                    DispatchQueue.main.async {
                        self.alignmentGuides = alignmentGuides
                    }
                }
            })
        }
    }

    // MARK: - Helpers

    func calculateAlignmentGuides(columns: Int, spacing: CGFloat, preferences: [ElementPreferenceData]) -> [AnyHashable: CGPoint] {
        var heights = Array(repeating: CGFloat(0), count: columns)
        var alignmentGuides = [AnyHashable: CGPoint]()

        preferences.forEach { preference in
            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
                let width = preference.size.width * CGFloat(indexMin) + CGFloat(indexMin) * spacing
                let height = heights[indexMin]
                let offset = CGPoint(x: 0 - width, y: 0 - height)
                heights[indexMin] += preference.size.height + spacing
                alignmentGuides[preference.id] = offset
            }
        }

        return alignmentGuides
    }

    func columnWidth(columns: Int, spacing: CGFloat, hPadding: CGFloat, geometrySize: CGSize) -> CGFloat {
        let width = geometrySize.width - (hPadding * 2) - (spacing * (CGFloat(columns) - 1))
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
    /// - Parameter columns: The number of columns of the grid.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter vPadding: The amount to inset the grid on the vertical edge. The default is `8`.
    /// - Parameter hPadding: The amount to inset the grid on the horizontal edge. The default is `8`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data,
                id: KeyPath<Data.Element, ID>,
                columns: Int,
                spacing: CGFloat = 8,
                vPadding: CGFloat = 8,
                hPadding: CGFloat = 8,
                animation: Animation? = .default,
                content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = id
        self.columnsInPortrait = columns
        self.columnsInLandscape = columns
        self.spacing = spacing
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.animation = animation
        self.content = content
    }

    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter columnsInPortrait: The number of columns of the grid when the device is in a portrait orientation.
    /// - Parameter columnsInLandscape: The number of columns of the grid when the device is in a landscape orientation.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter vPadding: The amount to inset the grid on the vertical edge. The default is `8`.
    /// - Parameter hPadding: The amount to inset the grid on the horizontal edge. The default is `8`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ data: Data,
                id: KeyPath<Data.Element, ID>,
                columnsInPortrait: Int,
                columnsInLandscape: Int,
                spacing: CGFloat = 8,
                vPadding: CGFloat = 8,
                hPadding: CGFloat = 8,
                animation: Animation? = .default,
                content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = id
        self.columnsInPortrait = columnsInPortrait
        self.columnsInLandscape = columnsInLandscape
        self.spacing = spacing
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.animation = animation
        self.content = content
    }

}

extension WaterfallGrid where ID == Data.Element.ID, Data.Element : Identifiable {

    /// Creates an instance that uniquely identifies views across updates based
    /// on the identity of the underlying data element.
    ///
    /// - Parameter data: A collection of identified data.
    /// - Parameter columns: The number of columns of the grid.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter vPadding: The amount to inset the grid on the vertical edge. The default is `8`.
    /// - Parameter hPadding: The amount to inset the grid on the horizontal edge. The default is `8`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data,
                columns: Int,
                spacing: CGFloat = 8,
                vPadding: CGFloat = 8,
                hPadding: CGFloat = 8,
                animation: Animation? = .default,
                content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = \Data.Element.id
        self.columnsInPortrait = columns
        self.columnsInLandscape = columns
        self.spacing = spacing
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.animation = animation
        self.content = content
    }

    /// Creates an instance that uniquely identifies views across updates based
    /// on the identity of the underlying data element.
    ///
    /// - Parameter data: A collection of identified data.
    /// - Parameter columnsInPortrait: The number of columns of the grid when the device is in a portrait orientation.
    /// - Parameter columnsInLandscape: The number of columns of the grid when the device is in a landscape orientation.
    /// - Parameter spacing: The distance between adjacent items. The default is `8`.
    /// - Parameter vPadding: The amount to inset the grid on the vertical edge. The default is `8`.
    /// - Parameter hPadding: The amount to inset the grid on the horizontal edge. The default is `8`.
    /// - Parameter animation: The animation to apply when data change. If `animation` is `nil`, the grid doesn't animate.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ data: Data,
                columnsInPortrait: Int,
                columnsInLandscape: Int,
                spacing: CGFloat = 8,
                vPadding: CGFloat = 8,
                hPadding: CGFloat = 8,
                animation: Animation? = .default,
                content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = \Data.Element.id
        self.columnsInPortrait = columnsInPortrait
        self.columnsInLandscape = columnsInLandscape
        self.spacing = spacing
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.animation = animation
        self.content = content
    }

}
