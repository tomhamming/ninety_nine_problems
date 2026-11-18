//
//  List<T>.swift
//  NinetyNine
//
//  Created by Thomas Hamming on 2/22/20.
//  Copyright © 2020 Thomas Hamming. All rights reserved.
//

protocol ListElement: Equatable {}

extension Int: ListElement {}

protocol ListProtocol {
    var payload: Any { get }
    var next: any ListProtocol? { get set }
    static func makeSingle(_ payload: Any) -> any ListProtocol
}

extension ListProtocol {
    func flatten() -> any ListProtocol {
        func processElement(_ element: any ListProtocol) -> any ListProtocol {
            if let listValue = element.payload as? any ListProtocol {
                return listValue.flatten()
            }
            else {
                return Self.makeSingle(element.payload)
            }
        }
        
        let result = processElement(self)
        
        var last = result.last()
        var iterator = self.next
        while iterator != nil {
            let tmp = processElement(iterator!)
            last.next = tmp
            last = tmp.last()
            iterator = iterator!.next
        }
        
        return result
    }
    
    func last() -> any ListProtocol {
        var result: any ListProtocol = self
        while let tmp = result.next {
            result = tmp
        }
        
        return result
    }
}

/// A list is either empty or it is composed of a first element (head)
/// and a tail, which is a list itself.
///
/// See http://www.enekoalonso.com/projects/99-swift-problems/#linked-lists
class List<T> : CustomDebugStringConvertible {
    var value: T
    var nextItem: List<T>?

    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init(singleValue: T) {
        self.value = singleValue
    }

    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
    
    var tail: List<T> {
        var result = self
        while let tmp = result.nextItem {
            result = tmp
        }
        
        return result
    }
    
    var last: T
    {
        return self.tail.value
    }
    
    var pennultimate: T?
    {
        guard let _ = self.nextItem else { return nil }
        
        var current: List<T>? = self.nextItem
        var prev: List<T>? = self
        var result: T? = nil
        repeat {
            result = prev?.value
            prev = current
            current = current?.nextItem
        } while (current != nil)
        
        return result
    }
    
    subscript(index: Int) -> T? {
        var count = 0
        var current: List<T>? = self;
        while (current != nil && count < index)
        {
            current = current?.nextItem
            count += 1
        }
        
        return (count == index ? current?.value : nil)
    }
    
    var length: Int {
        var result = 0
        var current: List<T>? = self
        repeat {
            current = current?.nextItem
            result += 1
        } while (current != nil)
        
        return result
    }
    
    var debugDescription: String { return "\(value)" } 
    
    func reversed() -> List<T> {
        var result = self
        while let next = self.nextItem {
            let tmp = next.nextItem
            next.nextItem = result
            result = next
            self.nextItem = tmp
        }
        
        return result
    }
    
    func copy() -> List<T> {
        let result = List<T>(singleValue: self.value)
        var iterator = self
        var last = result
        while let next = iterator.nextItem {
            let tmp = List<T>(singleValue: next.value)
            last.nextItem = tmp
            last = tmp
            iterator = next
        }
        
        return result
    }
}

extension List: ListElement where T: ListElement {
    
}

extension List: ListProtocol {
    var payload: Any { value }
    
    var next: (any ListProtocol)? {
        get {
            return self.nextItem
        }
        set {
            self.nextItem = newValue as? List<T>
        }
    }
    
    static func makeSingle(_ payload: Any) -> any ListProtocol {
        return List<T>(singleValue: payload as! T)
    }
}

extension List : Equatable where T : Equatable
{
    static func == (lhs: List<T>, rhs: List<T>) -> Bool
    {
        var lCurrent: List<T>? = lhs
        var rCurrent: List<T>? = rhs
        while (lCurrent != nil)
        {
            if (lCurrent?.value != rCurrent?.value)
            {
                return false
            }
            
            lCurrent = lCurrent?.nextItem
            rCurrent = rCurrent?.nextItem
        }
        
        return true
    }
    
    func isPalindrome() -> Bool {
        let copy = self.copy()
        return copy.reversed() == self
    }
    
    func compress() {
        var currNode = self
        var next = self.nextItem
        while next != nil {
            if next?.value != currNode.value {
                currNode.nextItem = next
                currNode = next!
            }
            
            next = next?.nextItem
        }
        
        currNode.nextItem = nil
    }
}
