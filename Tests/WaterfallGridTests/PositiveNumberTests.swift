//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import XCTest
@testable import WaterfallGrid

class PositiveNumberTests: XCTestCase {
    
    @PositiveNumber var sut: Int = 1
    
    func test_setPositiveNumber_getSameNumber() {
        sut = 100
        XCTAssertEqual(sut, 100)
    }
    
    func test_setZero_getOne() {
        sut = 0
        XCTAssertEqual(sut, 1)
    }
    
    func test_setNegativeNumber_getOne() {
        sut = -100
        XCTAssertEqual(sut, 1)
    }
    
}
