//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

/// A container that presents items of variable heights arranged in a grid.
@available(iOS 13, OSX 10.15, tvOS 13, watchOS 6, *)
public struct WaterfallGrid<Data, ID, Header, Footer, Content>: View where Data : RandomAccessCollection, Content : View, ID : Hashable, Header : View, Footer : View {

    @Environment(\.gridStyle) private var style
    @Environment(\.scrollOptions) private var scrollOptions

    private let data: Data
    private let dataId: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    private let header: Header?
    private let footer: Footer?

    @State private var loaded = false

    @State private var alignmentGuides = [AnyHashable: CGPoint]() {
        didSet { loaded = !oldValue.isEmpty }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.grid(in: geometry)
                .onPreferenceChange(ElementPreferenceKey.self, perform: { preferences in
                    DispatchQueue.global(qos: .utility).async {
                        let alignmentGuides = self.calculateAlignmentGuides(columns: self.style.columns,
                                                                            spacing: self.style.spacing,
                                                                            scrollDirection: self.scrollOptions.direction,
                                                                            preferences: preferences)
                        DispatchQueue.main.async {
                            self.alignmentGuides = alignmentGuides
                        }
                    }
                })
        }
    }

    private func grid(in geometry: GeometryProxy) -> some View {
        let columnWidth = self.columnWidth(columns: style.columns, spacing: style.spacing, padding: style.padding,
                                           scrollDirection: scrollOptions.direction, geometrySize: geometry.size)
        return ScrollView(scrollOptions.direction, showsIndicators: scrollOptions.showsIndicators) {
            VStack {
                header.padding(padding(for: .header))
                
                ZStack(alignment: .topLeading) {
                    ForEach(data, id: self.dataId) { element in
                        self.content(element)
                            .frame(width: self.scrollOptions.direction == .vertical ? columnWidth : nil,
                                   height: self.scrollOptions.direction == .horizontal ? columnWidth : nil)
                            .background(PreferenceSetter(id: element[keyPath: self.dataId]))
                            .alignmentGuide(.top, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.y ?? 0 })
                            .alignmentGuide(.leading, computeValue: { _ in self.alignmentGuides[element[keyPath: self.dataId]]?.x ?? 0 })
                            .opacity(self.alignmentGuides[element[keyPath: self.dataId]] != nil ? 1 : 0)
                    }
                }
                .padding(padding(for: .content))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(self.loaded ? self.style.animation : nil)
                
                footer.padding(padding(for: .footer))
            }
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

// MARK: - Helpers

private extension WaterfallGrid {
    enum PaddingLocation {
        case header
        case content
        case footer
    }
    
    func padding(for location: PaddingLocation) -> EdgeInsets {
        switch location {
        case .header:
            guard header != nil else {
                return EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
            }
            
            return EdgeInsets(top: style.padding.top, leading: style.padding.leading, bottom: style.spacing, trailing: style.padding.trailing)
        case .content:
            return EdgeInsets(top: header == nil ? style.padding.top : 0.0, leading: style.padding.leading, bottom: footer == nil ? style.padding.bottom : 0.0, trailing: style.padding.trailing)
        case .footer:
            guard footer != nil else {
                return EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
            }
            
            return EdgeInsets(top: style.spacing, leading: style.padding.leading, bottom: style.padding.bottom, trailing: style.padding.trailing)
        }
    }
}

// MARK: - Initializers

extension WaterfallGrid {

    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter header: Header to be displayed above content
    /// - Parameter footer: Footer to be displayed below content.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, header: Header?, footer: Footer?, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = id
        self.header = header
        self.footer = footer
        self.content = content
    }
    
}

extension WaterfallGrid where Header == EmptyView {
    
    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter header: Header to be displayed above content
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, footer: Footer?, content: @escaping (Data.Element) -> Content) {
        self.init(data, id: id, header: nil, footer: footer, content: content)
    }
}

extension WaterfallGrid where Footer == EmptyView {
    
    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter header: Header to be displayed above content
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, header: Header?, content: @escaping (Data.Element) -> Content) {
        self.init(data, id: id, header: header, footer: nil, content: content)
    }
}

extension WaterfallGrid where ID == Data.Element.ID, Data.Element : Identifiable, Header == EmptyView, Footer == EmptyView {

    /// Creates an instance that uniquely identifies views across updates based
    /// on the `id` key path to a property on an underlying data element.
    ///
    /// - Parameter data: A collection of data.
    /// - Parameter id: Key path to a property on an underlying data element.
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content) {
        self.init(data, id: id, header: nil, footer: nil, content: content)
    }
    
    /// Creates an instance that uniquely identifies views across updates based
    /// on the identity of the underlying data element.
    ///
    /// - Parameter data: A collection of identified data.
    /// - Parameter header: Header to be displayed above content
    /// - Parameter footer: Footer to be displayed below content
    /// - Parameter content: A function that can be used to generate content on demand given underlying data.
    public init(_ data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.dataId = \Data.Element.id
        self.header = nil
        self.footer = nil
        self.content = content
    }

}
