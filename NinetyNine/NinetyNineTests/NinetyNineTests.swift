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

    func testP02()
    {
        var l = List(1)
        XCTAssertEqual(l?.pennultimate, nil)
        
        l = List(1, 2)
        XCTAssertEqual(l?.pennultimate, 1)
        
        l = List(0)
        XCTAssertEqual(l?.pennultimate, nil)
        
        l = List(1, 0, 1)
        XCTAssertEqual(l?.pennultimate, 0)
        
        l = List(1, 2, 3)
        XCTAssertEqual(l?.pennultimate, 2)
        
        l = List(1, 2, 5, 5, 4)
        XCTAssertEqual(l?.pennultimate, 5)
    }
    
    func testP03()
    {
        var l = List(1)
        XCTAssertEqual(l?[0], 1)
        XCTAssertEqual(l?[1], nil)
        XCTAssertEqual(l?[-1], nil)
        
        l = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(l?[-1], nil)
        XCTAssertEqual(l?[0], 1)
        XCTAssertEqual(l?[1], 1)
        XCTAssertEqual(l?[2], 2)
        XCTAssertEqual(l?[100], nil)
    }
    
    func testP04()
    {
        var l = List(1)
        XCTAssertEqual(l?.length, 1)
        
        l = List(1, 2, 3)
        XCTAssertEqual(l?.length, 3)
        
        l = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(l?.length, 6)
    }
    
    func testEquality()
    {
        XCTAssertEqual(List(1), List(1))
        XCTAssertEqual(List(1, 2), List(1, 2))
        XCTAssertEqual(List(1, 2, 3), List(1, 2, 3))
        XCTAssertNotEqual(List(1), List(2))
        XCTAssertNotEqual(List(1, 2), List(1, 3))
        XCTAssertNotEqual(List(1, 2), List(1))
        XCTAssertNotEqual(List(1, 2, 3), List(1, 2))
    }
    
    func testP05()
    {
        var l = List(1)!
        l.reverse()
        XCTAssertEqual(l, List(1))
        
        l = List(1, 2)!
        l.reverse()
        XCTAssertEqual(l, List(2, 1))
        
        l = List(1, 2, 3)!
        l.reverse()
        XCTAssertEqual(l, List(3, 2, 1))
        
        l = List(1, 2, 3, 4)!
        l.reverse()
        XCTAssertEqual(l, List(4, 3, 2, 1))
        
        l = List(1, 2, 3, 4, 5)!
        l.reverse()
        XCTAssertEqual(l, List(5, 4, 3, 2, 1))
        
        l = List(1, 2, 3, 4, 5, 6)!
        l.reverse()
        XCTAssertEqual(l, List(6, 5, 4, 3, 2, 1))
        
        l = List(1, 2, 3, 4, 5, 4, 3, 2, 2)!
        l.reverse()
        XCTAssertEqual(l, List(2, 2, 3, 4, 5, 4, 3, 2, 1))
    }
}
