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
        sut = WaterfallGrid((0...0), id: \.self) { Text("\($0)") }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_calculateAlignmentGuides_withSpacingAndVerticalScroll() {
        // Given
        let width = 40
        let spacing: CGFloat = 8
        let scrollDirection = Axis.Set.vertical
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
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, scrollDirection: scrollDirection, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_calculateAlignmentGuides_withSpacingAndHorizontalScroll() {
        // Given
        let height = 40
        let spacing: CGFloat = 8
        let scrollDirection = Axis.Set.horizontal
        let preferences = [
            ElementPreferenceData(id: 0, size: CGSize(width: 100, height: height)),
            ElementPreferenceData(id: 1, size: CGSize(width: 80, height: height)),
            ElementPreferenceData(id: 2, size: CGSize(width: 60, height: height)),
            ElementPreferenceData(id: 3, size: CGSize(width: 120, height: height)),
            ElementPreferenceData(id: 4, size: CGSize(width: 30, height: height))
        ]

        let alignmentsOneColumn: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -108, y: 0),
            2: CGPoint(x: -196, y: 0),
            3: CGPoint(x: -264, y: 0),
            4: CGPoint(x: -392, y: 0)
        ]

        let alignmentsTwoColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -48),
            2: CGPoint(x: -88, y: -48),
            3: CGPoint(x: -108, y: 0),
            4: CGPoint(x: -156, y: -48)
        ]

        let alignmentsThreeColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -48),
            2: CGPoint(x: 0, y: -96),
            3: CGPoint(x: -68, y: -96),
            4: CGPoint(x: -88, y: -48)
        ]

        let testCases: [ ([AnyHashable : CGPoint], Int, UInt) ] = [
            // expected             | columns |  line
            (alignmentsOneColumn,       1,      #line),
            (alignmentsTwoColumns,      2,      #line),
            (alignmentsThreeColumns,    3,      #line)
        ]

        for (expected, columns, line) in testCases {
            // When
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, scrollDirection: scrollDirection, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_calculateAlignmentGuides_withoutSpacingAndVerticalScroll() {
        // Given
        let width = 40
        let spacing: CGFloat = 0
        let scrollDirection = Axis.Set.vertical
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
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, scrollDirection: scrollDirection, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_calculateAlignmentGuides_withoutSpacingAndHorizontalScroll() {
        // Given
        let height = 40
        let spacing: CGFloat = 0
        let scrollDirection = Axis.Set.horizontal
        let preferences = [
            ElementPreferenceData(id: 0, size: CGSize(width: 100, height: height)),
            ElementPreferenceData(id: 1, size: CGSize(width: 80, height: height)),
            ElementPreferenceData(id: 2, size: CGSize(width: 60, height: height)),
            ElementPreferenceData(id: 3, size: CGSize(width: 120, height: height)),
            ElementPreferenceData(id: 4, size: CGSize(width: 30, height: height))
        ]

        let alignmentsOneColumn: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: -100, y: 0),
            2: CGPoint(x: -180, y: 0),
            3: CGPoint(x: -240, y: 0),
            4: CGPoint(x: -360, y: 0)
        ]

        let alignmentsTwoColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -40),
            2: CGPoint(x:  -80, y:-40),
            3: CGPoint(x: -100, y: 0),
            4: CGPoint(x: -140, y: -40)
        ]

        let alignmentsThreeColumns: [AnyHashable : CGPoint] = [
            0: CGPoint(x: 0, y: 0),
            1: CGPoint(x: 0, y: -40),
            2: CGPoint(x: 0, y: -80),
            3: CGPoint(x: -60, y: -80),
            4: CGPoint(x: -80, y: -40)
        ]

        let testCases: [ ([AnyHashable : CGPoint], Int, UInt) ] = [
            // expected             | columns |  line
            (alignmentsOneColumn,       1,      #line),
            (alignmentsTwoColumns,      2,      #line),
            (alignmentsThreeColumns,    3,      #line)
        ]

        for (expected, columns, line) in testCases {
            // When
            let result = sut.calculateAlignmentGuides(columns: columns, spacing: spacing, scrollDirection: scrollDirection, preferences: preferences)
            // Then
            XCTAssertEqual(expected, result, line: line)
        }
    }

    func test_columnWidth_verticalScrolling() {
        // Given
        let edgeInsets: [EdgeInsets] = [
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 0, leading: 4, bottom: 0, trailing: 4),
            .init(top: 0, leading: 4, bottom: 0, trailing: 6.5),
            .init(top: 0, leading: 6.5, bottom: 0, trailing: 2)
        ]

        let geometrySize = CGSize(width: 400, height: 600)
        let testCases: [(CGFloat, Int, CGFloat, EdgeInsets, UInt)] = [
            // expected  | columns  |   spacing   |    padding    | line
            (400,           1,          0,          edgeInsets[0],   #line),
            (400,           1,          8,          edgeInsets[1],   #line),
            (400,           1,          10.5,       edgeInsets[2],   #line),
            (392,           1,          0,          edgeInsets[3],   #line),
            (389.5,         1,          0,          edgeInsets[4],   #line),
            (391.5,         1,          8,          edgeInsets[5],   #line),

            (200,           2,          0,          edgeInsets[0],   #line),
            (196,           2,          8,          edgeInsets[1],   #line),
            (194.75,        2,          10.5,       edgeInsets[2],   #line),
            (196,           2,          0,          edgeInsets[3],   #line),
            (194.75,        2,          0,          edgeInsets[4],   #line),
            (191.75,        2,          8,          edgeInsets[5],   #line),

            (133.33,        3,          0,          edgeInsets[0],   #line),
            (128,           3,          8,          edgeInsets[1],   #line),
            (126.33,        3,          10.5,       edgeInsets[2],   #line),
            (130.66,        3,          0,          edgeInsets[3],   #line),
            (129.83,        3,          0,          edgeInsets[4],   #line),
            (125.16,        3,          8,          edgeInsets[5],   #line)
        ]

        for (expected, columns, spacing, padding, line) in testCases {
            // When
            let result = sut.columnWidth(columns: columns, spacing: spacing, padding: padding, scrollDirection: .vertical, geometrySize: geometrySize)
            // Then
            XCTAssertEqual(expected, result, accuracy: 0.01, line: line)
        }
    }

    func test_columnWidth_horizontalScrolling() {
        // Given
        let edgeInsets: [EdgeInsets] = [
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            .init(top: 4, leading: 0, bottom: 4, trailing: 0),
            .init(top: 4, leading: 0, bottom: 6.5, trailing: 0),
            .init(top: 6.5, leading: 0, bottom: 2, trailing: 0)
        ]

        let geometrySize = CGSize(width: 400, height: 600)
        let testCases: [(CGFloat, Int, CGFloat, EdgeInsets, UInt)] = [
            // expected  | columns  |   spacing   |    padding    | line
            (600,           1,          0,          edgeInsets[0],   #line),
            (600,           1,          8,          edgeInsets[1],   #line),
            (600,           1,          10.5,       edgeInsets[2],   #line),
            (592,           1,          0,          edgeInsets[3],   #line),
            (589.5,         1,          0,          edgeInsets[4],   #line),
            (591.5,         1,          8,          edgeInsets[5],   #line),

            (300,           2,          0,          edgeInsets[0],   #line),
            (296,           2,          8,          edgeInsets[1],   #line),
            (294.75,        2,          10.5,       edgeInsets[2],   #line),
            (296,           2,          0,          edgeInsets[3],   #line),
            (294.75,        2,          0,          edgeInsets[4],   #line),
            (291.75,        2,          8,          edgeInsets[5],   #line),

            (200,           3,          0,          edgeInsets[0],   #line),
            (194.66,        3,          8,          edgeInsets[1],   #line),
            (193,           3,          10.5,       edgeInsets[2],   #line),
            (197.33,        3,          0,          edgeInsets[3],   #line),
            (196.5,         3,          0,          edgeInsets[4],   #line),
            (191.83,        3,          8,          edgeInsets[5],   #line)
        ]

        for (expected, columns, spacing, padding, line) in testCases {
            // When
            let result = sut.columnWidth(columns: columns, spacing: spacing, padding: padding, scrollDirection: .horizontal, geometrySize: geometrySize)
            // Then
            XCTAssertEqual(expected, result, accuracy: 0.01, line: line)
        }
    }

}
