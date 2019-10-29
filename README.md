# WaterfallGrid

A waterfall grid layout view for SwiftUI.

<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/demo1.png" alt="Image Demo 1"/>
</p>

<p align="center">
	<img src="https://img.shields.io/bitrise/deaf4a89eca9a69a?token=tU52Wx6TQeKRWAiTE5iS3g&style=flat" />
	<img src="https://img.shields.io/badge/Swift-5.1-red?style=flat" />
	<a href="https://swift.org/package-manager">
		<img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
	</a>
	<img src="https://img.shields.io/github/v/tag/paololeonardi/WaterfallGrid?style=flat" />
	<a href="https://twitter.com/paololeonardi">
		<img src="https://img.shields.io/badge/contact-@paololeonardi-blue.svg?style=flat" alt="Twitter: @paololeonardi" />
	</a>
</p>

## Features

- [x] Items fill the most available vertical space.
- [x] Columns number different per device orientation.
- [x] Spacing and grid padding customizable.
- [x] Items update can be animated.

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 11.0+
- Swift 5.1+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding WaterfallGrid as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/paololeonardi/WaterfallGrid.git"))
]
```

## Usage

You can create a grid that displays the elements of collection by passing your collection of data and a closure that provides a view for each element in the collection. The grid transforms each element in the collection into a child view by using the supplied closure.

WaterfallGrid works with identifiable data (like SwiftUI.List). You can make your data identifiable in one of two ways: by passing along with your data a key path to a property that uniquely identifies each element, or by making your data type conform to the Identifiable protocol.

**Example 1**

A grid of views of type `Image ` from a collection of data identified by a key path.

```swift
WaterfallGrid((0..<10), id: \.self, columns: 2) { index in
	Image("image\(index)")
		.resizable()
		.aspectRatio(contentMode: .fit)
}
```

**Example 2**

A grid of views of type `RectangleView ` from a collection of `Identifiable` data.

In this example, we are also passing to the initializer all the available properties to customize the appearance and the animation of the grid.

```swift
WaterfallGrid(rectangles,
              columnsInPortrait: 2,
              columnsInLandscape: 3,
              spacing: 8,
              vPadding: 8,
              hPadding: 8,
              animation: .easeInOut
) { rectangle in
    RectangleView(rectangle: rectangle)
}
```

## Sample App
Explore the `WaterfallGridSample` app for some more detailed and interactive examples.

<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/animation1.gif" alt="Animation Demo 1" width="250"/>&nbsp;
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/animation2.gif" alt="Animation Demo 2" width="250"/>&nbsp;
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/animation3.gif" alt="Animation Demo 3" width="250"/>
</p>
<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/demo3.png" alt="Image Demo 3"/>
</p>
<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/demo2.png" alt="Image Demo 2"/>
</p>

## Versioning

For the versions available, see the [tags on this repository](https://github.com/paololeonardi/WaterfallGrid/tags). 

## Author
* [Paolo Leonardi](https://github.com/paololeonardi) ([@paololeonardi](https://twitter.com/paololeonardi))

## Credits
WaterfallGrid was ispired by the following projects:

* QGrid - https://github.com/Q-Mobile/QGrid
* Grid - https://github.com/SwiftUIExtensions/Grid
* The SwiftUI Lab - https://swiftui-lab.com

## License

WaterfallGrid is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

