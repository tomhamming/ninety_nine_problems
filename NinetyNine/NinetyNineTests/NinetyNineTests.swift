//
//  NinetyNineTests.swift
//  NinetyNineTests
//
//  Created by Thomas Hamming on 2/22/20.
//  Copyright © 2020 Thomas Hamming. All rights reserved.
//

import Testing
@testable import NinetyNine

struct NinetyNineTests {

    @Test func testP01() {
        var l = List(1)
        #expect(l?.last == 1)

        l = List(1, 2)
        #expect(l?.last == 2)

        l = List(1, 2, 3)
        #expect(l?.last == 3)

        l = List(1, 1, 1)
        #expect(l?.last == 1)

        l = List(1, 1, -1)
        #expect(l?.last == -1)
    }

    @Test func testP02() {
        var l = List(1)
        #expect(l?.pennultimate == nil)

        l = List(1, 2)
        #expect(l?.pennultimate == 1)

        l = List(0)
        #expect(l?.pennultimate == nil)

        l = List(1, 0, 1)
        #expect(l?.pennultimate == 0)

        l = List(1, 2, 3)
        #expect(l?.pennultimate == 2)

        l = List(1, 2, 5, 5, 4)
        #expect(l?.pennultimate == 5)
    }
    
    @Test func testP03() {
        var l = List(1)
        #expect(l?[0] == 1)
        #expect(l?[1] == nil)
        #expect(l?[-1] == nil)

        l = List(1, 1, 2, 3, 5, 8)
        #expect(l?[-1] == nil)
        #expect(l?[0] == 1)
        #expect(l?[1] == 1)
        #expect(l?[2] == 2)
        #expect(l?[100] == nil)
    }
    
    @Test func testP04() {
        var l = List(1)
        #expect(l?.length == 1)

        l = List(1, 2, 3)
        #expect(l?.length == 3)

        l = List(1, 1, 2, 3, 5, 8)
        #expect(l?.length == 6)
    }
    
    @Test func testEquality() {
        #expect(List(1) == List(1))
        #expect(List(1, 2) == List(1, 2))
        #expect(List(1, 2, 3) == List(1, 2, 3))
        #expect(List(1) != List(2))
        #expect(List(1, 2) != List(1, 3))
        #expect(List(1, 2) != List(1))
        #expect(List(1, 2, 3) != List(1, 2))
    }
    
    @Test func testP05() {
        var l = List(1)!
        #expect(l.reversed() == List(1))

        l = List(1, 2)!
        #expect(l.reversed() == List(2, 1))

        l = List(1, 2, 3)!
        #expect(l.reversed() == List(3, 2, 1))

        l = List(1, 2, 3, 4)!
        #expect(l.reversed() == List(4, 3, 2, 1))

        l = List(1, 2, 3, 4, 5)!
        #expect(l.reversed() == List(5, 4, 3, 2, 1))

        l = List(1, 2, 3, 4, 5, 6)!
        #expect(l.reversed() == List(6, 5, 4, 3, 2, 1))

        l = List(1, 2, 3, 4, 5, 4, 3, 2, 2)!
        #expect(l.reversed() == List(2, 2, 3, 4, 5, 4, 3, 2, 1))
    }
    
    @Test func testP06() {
        var l = List(1)!
        #expect(l.isPalindrome())

        l = List(1, 2)!
        #expect(!l.isPalindrome())

        l = List(1, 1)!
        #expect(l.isPalindrome())

        l = List(1, 2, 1)!
        #expect(l.isPalindrome())

        l = List(1, 2, 3, 4, 5, 4, 3, 2, 1)!
        #expect(l.isPalindrome())

        l = List(1, 2, 3, 4, 5, 4, 3, 2, 2)!
        #expect(!l.isPalindrome())
    }
    
    @Test func testP07() {
        func test(orig: List<Any>, expected: [Int]) {
            let flat = orig.flatten()
            
            var actual: [Int] = []
            var current: (any ListProtocol)? = flat
            while let node = current {
                actual.append(node.payload as! Int)
                current = node.next
            }
            
            #expect(actual == expected)
        }
        
        var l = List<Any>(List<Any>(1, 1)!, 2, List<Any>(3, List<Any>(5, 8)!)!)!
        test(orig: l, expected: [1, 1, 2, 3, 5, 8]);
        
        
        l = List<Any>(5, List<Any>(1, 1)!, 2, List<Any>(3, List<Any>(5, 8)!, 42)!)!
        test(orig: l, expected: [5, 1, 1, 2, 3, 5, 8, 42]);
        
        l = List<Any>(5, List<Any>(1, 1, List<Any>(4, 5)!)!, 2, List<Any>(3, List<Any>(5, 8)!, 42)!)!
        test(orig: l, expected: [5, 1, 1, 4, 5, 2, 3, 5, 8, 42]);
    }
    
    @Test func testP08() {
        var list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        list.compress()
        
        #expect(list == List("a", "b", "c", "a", "d", "e"))

        list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e", "f")!
        list.compress()
        
        #expect(list == List("a", "b", "c", "a", "d", "e", "f"))

        list = List("a", "a", "a", "a", "b", "a", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        list.compress()
        
        #expect(list == List("a", "b", "a", "c", "a", "d", "e"))
    }
}
