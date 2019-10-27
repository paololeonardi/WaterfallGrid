# WaterfallGrid

A waterfall grid layout view for SwiftUI.

<center>
<img src="Assets/demo1.png"/>
</center>

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

```swift
WaterfallGrid(images, columns: 2) { image in
    Image(image.name)
        .resizable()
        .aspectRatio(contentMode: .fit)
}
```

```swift
WaterfallGrid((0..<cards.count),
              id: \.self,
              columnsInPortrait: 2,
              columnsInLandscape: 3,
              spacing: 8,
              vPadding: 8,
              hPadding: 8,
              animation: .easeInOut
) { index in
    CardView(card: self.cards[index])
}
```

## Versions

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

