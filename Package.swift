// swift-tools-version:5.1

//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import PackageDescription

let package = Package(
    name: "WaterfallGrid",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "WaterfallGrid",
            targets: ["WaterfallGrid"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WaterfallGrid",
            dependencies: []),
        .testTarget(
            name: "WaterfallGridTests",
            dependencies: ["WaterfallGrid"]),
    ]
)
