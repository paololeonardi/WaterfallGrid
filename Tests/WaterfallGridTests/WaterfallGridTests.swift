//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import XCTest
import SwiftUI
@testable import WaterfallGrid

class WaterfallGridTests: XCTestCase {

    var sut: WaterfallGrid<ClosedRange<Int>, Int, Text>!

    override func setUp() {
        super.setUp()
        sut = WaterfallGrid((0...0), id: \.self, columns: 2) { Text("\($0)") }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_calculateAlignmentGuides_withSpacing() {
        // Given
        let width = 40
        let spacing: CGFloat = 8
        let preferences = [
            ElementPreferenceData(id: 0, size: CGSize(width: width, height: 100)),
            ElementPreferenceData(id: 1, size: CGSize(width: width, height: 80)),
            ElementPreferenceData(id: 2, size: CGSize(width: width, height: 60)),
            ElementPreferenceData(id: 3, size: CGSize(width: width, height: 120)),
            ElementPreferenceData(id: 4, size: CGSize(width: width, height: 30))
        ]

        let alignmentsOneColumn: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -108),
            2: CGPoint(x: 0, y: -196),
            3: CGPoint(x: 0, y: -264),
            4: CGPoint(x: 0, y: -392)
        ]

        let alignmentsTwoColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -48, y: 0),
            2: CGPoint(x: -48, y: -88),
            3: CGPoint(x: 0, y: -108),
            4: CGPoint(x: -48, y: -156)
        ]

        let alignmentsThreeColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -48, y: 0),
            2: CGPoint(x: -96, y: 0),
            3: CGPoint(x: -96, y: -68),
            4: CGPoint(x: -48, y: -88)
        ]

        let testCases: [ ([AnyHashable : CGPoint], Int, UInt) ] = [
            // expected             | columns |  line
            (alignmentsOneColumn,       1,      #line),
            (alignmentsTwoColumns,      2,      #line),
            (alignmentsThreeColumns,    3,      #line)
        ]

        for (expected, columns, line) in testCases {
            // When
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_calculateAlignmentGuides_withoutSpacing() {
        // Given
        let width = 40
        let spacing: CGFloat = 0
        let preferences = [
            ElementPreferenceData(id: 0, size: CGSize(width: width, height: 100)),
            ElementPreferenceData(id: 1, size: CGSize(width: width, height: 80)),
            ElementPreferenceData(id: 2, size: CGSize(width: width, height: 60)),
            ElementPreferenceData(id: 3, size: CGSize(width: width, height: 120)),
            ElementPreferenceData(id: 4, size: CGSize(width: width, height: 30))
        ]

        let alignmentsOneColumn: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -100),
            2: CGPoint(x: 0, y: -180),
            3: CGPoint(x: 0, y: -240),
            4: CGPoint(x: 0, y: -360)
        ]

        let alignmentsTwoColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -40, y: 0),
            2: CGPoint(x: -40, y: -80),
            3: CGPoint(x: 0, y: -100),
            4: CGPoint(x: -40, y: -140)
        ]

        let alignmentsThreeColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -40, y: 0),
            2: CGPoint(x: -80, y: 0),
            3: CGPoint(x: -80, y: -60),
            4: CGPoint(x: -40, y: -80)
        ]

        let testCases: [ ([AnyHashable : CGPoint], Int, UInt) ] = [
            // expected             | columns |  line
            (alignmentsOneColumn,       1,      #line),
            (alignmentsTwoColumns,      2,      #line),
            (alignmentsThreeColumns,    3,      #line)
        ]

        for (expected, columns, line) in testCases {
            // When
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_columnWidth() {
        // Given
        let geometrySize = CGSize(width: 400, height: 400)
        let testCases: [(CGFloat, Int, CGFloat, CGFloat, UInt)] = [
            // expected | columns |  spacing  |  hPadding  | line
            (400,           1,          0,          0,      #line),
            (400,           1,          8,          0,      #line),
            (400,           1,          10.5,       0,      #line),
            (384,           1,          0,          8,      #line),
            (379,           1,          0,          10.5,   #line),
            (379,           1,          8,          10.5,   #line),

            (200,           2,          0,          0,      #line),
            (196,           2,          8,          0,      #line),
            (194.75,        2,          10.5,       0,      #line),
            (192,           2,          0,          8,      #line),
            (189.5,         2,          0,          10.5,   #line),
            (185.5,         2,          8,          10.5,   #line),

            (133.33,        3,          0,          0,      #line),
            (128,           3,          8,          0,      #line),
            (126.33,        3,          10.5,       0,      #line),
            (128,           3,          0,          8,      #line),
            (126.33,        3,          0,          10.5,   #line),
            (121,           3,          8,          10.5,   #line)
        ]

        for (expected, columns, spacing, hPadding, line) in testCases {
            // When
            let result = sut.columnWidth(columns: columns, spacing: spacing, hPadding: hPadding, geometrySize: geometrySize)
            // Then
            XCTAssertEqual(expected, result, accuracy: 0.01, line: line)
        }
    }

}
