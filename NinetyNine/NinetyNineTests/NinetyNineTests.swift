//
//  NinetyNineTests.swift
//  NinetyNineTests
//
//  Created by Thomas Hamming on 2/22/20.
//  Copyright © 2020 Thomas Hamming. All rights reserved.
//

import XCTest
@testable import NinetyNine

class NinetyNineTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testP01() {
        var l = List(1)
        XCTAssertEqual(l?.last, 1)
        
        l = List(1, 2)
        XCTAssertEqual(l?.last, 2)
        
        l = List(1, 2, 3)
        XCTAssertEqual(l?.last, 3)
        
        l = List(1, 1, 1)
        XCTAssertEqual(l?.last, 1)
        
        l = List(1, 1, -1)
        XCTAssertEqual(l?.last, -1)
    }

}