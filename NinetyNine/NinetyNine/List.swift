//
//  List<T>.swift
//  NinetyNine
//
//  Created by Thomas Hamming on 2/22/20.
//  Copyright © 2020 Thomas Hamming. All rights reserved.
//

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

    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
    
    var last: T?
    {
        var current: List<T>? = self
        var result: T? = nil
        repeat
        {
            result = current?.value
            current = current?.nextItem
        } while (current != nil)
        
        return result
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
}
