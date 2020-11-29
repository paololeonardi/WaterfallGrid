# WaterfallGrid

A waterfall grid layout view for SwiftUI.

<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/demo1.png" alt="Image Demo 1"/>
</p>

<p align="center">
	<img src="https://img.shields.io/bitrise/deaf4a89eca9a69a?token=tU52Wx6TQeKRWAiTE5iS3g&style=flat" />
	<img src="https://img.shields.io/badge/Swift-5.1-red?style=flat" />
	<img src="https://img.shields.io/cocoapods/p/WaterfallGrid" />
	<a href="https://swift.org/package-manager">
		<img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
	</a>
	<img src="https://img.shields.io/cocoapods/v/WaterfallGrid?color=blue" />
	<a href="https://twitter.com/paololeonardi">
		<img src="https://img.shields.io/badge/contact-@paololeonardi-blue.svg?style=flat" alt="Twitter: @paololeonardi" />
	</a>
</p>

## Features

- [x] Irregular grid of content.
- [x] Columns number different per device orientation.
- [x] Spacing and grid padding customizable.
- [x] Horizontal or vertical scroll direction.
- [x] Items update can be animated.

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 11.0+
- Swift 5.1+

## Usage

### Initialization

You can create a grid that displays the elements of collection by passing your collection of data and a closure that provides a view for each element in the collection. The grid transforms each element in the collection into a child view by using the supplied closure.

WaterfallGrid works with identifiable data (like SwiftUI.List). You can make your data identifiable in one of two ways: by passing along with your data a key path to a property that uniquely identifies each element, or by making your data type conform to the Identifiable protocol.

**Example 1**

A grid of views of type `Image` from a collection of data identified by a key path.

```swift
WaterfallGrid((0..<10), id: \.self) { index in
  Image("image\(index)")
    .resizable()
    .aspectRatio(contentMode: .fit)
}
```

**Example 2**

A grid of views of type `RectangleView` from a collection of `Identifiable` data.

```swift
WaterfallGrid(rectangles) { rectangle in
  RectangleView(rectangle: rectangle)
}
```
or, for simple cases like this, just:

```swift
WaterfallGrid(rectangles, content: RectangleView.init)
```

### Grid Style 

To customise the appearance of the grid call the `gridStyle` function and pass the parameters you want to customise.

**Columns**

```swift
WaterfallGrid(cards) { card in
  CardView(card: card)
}
.gridStyle(columns: 2)
```

```swift
WaterfallGrid(cards, content: CardView.init)
.gridStyle(
  columnsInPortrait: 2,
  columnsInLandscape: 3
)
```

**Spacing and Padding**

```swift
WaterfallGrid(rectangles, content: RectangleView.init)
.gridStyle(spacing: 8)
.padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
```

**Animation**

```swift
WaterfallGrid(rectangles, content: RectangleView.init)
.gridStyle(animation: .easeInOut(duration: 0.5))
```

### Scroll Behaviour

**Embed in ScrollView & Indicators option**

```swift
ScrollView(showsIndicators: true) {
  WaterfallGrid(rectangles, content: RectangleView.init)
}
```

**Horizontal Scroll Direction**

```swift
ScrollView(.horizontal) {
  WaterfallGrid(rectangles, content: RectangleView.init)
  .scrollOptions(direction: .horizontal)
}
```
<p align="center">
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/animation4.gif" alt="Animation Demo 4"/>
	<img src="https://paololeonardi.github.io/waterfallgrid/resources/animation5.gif" alt="Animation Demo 5"/>
</p>

### A Complete Example

```swift
ScrollView(.horizontal, showsIndicators: false) {
  WaterfallGrid(cards) { card in
    CardView(card: card)
  }
  .gridStyle(
    columnsInPortrait: 2,
    columnsInLandscape: 3,
    spacing: 8,
    animation: .easeInOut(duration: 0.5)
  )
  .scrollOptions(direction: .horizontal)
  .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
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

## Installation

### Swift Package Manager

**App dependency**

select File > Swift Packages > Add Package Dependency and enter the repository URL ([Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app))

**Package dependency**

Add it as a dependency within your `Package.swift` manifest:

```swift
dependencies: [
  .package(url: "https://github.com/paololeonardi/WaterfallGrid.git", from: "1.0.0")
]
```

### CocoaPods

You can install `WaterfallGrid` via CocoaPods by adding the following line to your `Podfile`:

```ruby
pod 'WaterfallGrid', '~> 1.0.0'
```

Run the `pod install` command to download the library
and integrate it into your Xcode project.

## Migration Guides

- [WaterfallGrid 1.0.0 Migration Guide](https://github.com/paololeonardi/WaterfallGrid/wiki/WaterfallGrid-1.0.0-Migration-Guide)

## Versioning

For the versions available, see the [releases on this repository](https://github.com/paololeonardi/WaterfallGrid/releases). 

## Contributing

Contributions are more than welcome. Please create a GitHub issue before submitting a pull request to plan and discuss implementation.

## Author
* [Paolo Leonardi](https://github.com/paololeonardi) ([@paololeonardi](https://twitter.com/paololeonardi))

## Credits
WaterfallGrid was ispired by the following projects:

* QGrid - https://github.com/Q-Mobile/QGrid
* Grid - https://github.com/SwiftUIExtensions/Grid
* The SwiftUI Lab - https://swiftui-lab.com

## License

WaterfallGrid is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

