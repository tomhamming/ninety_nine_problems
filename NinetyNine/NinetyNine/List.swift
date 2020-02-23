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
    
    func reverse()
    {
        //special case: 1 item, no reverse operation
        guard var prev = self.nextItem else { return }
        
        //special case: 2 items, just switch values
        guard var current = prev.nextItem else {
            let tmp = self.value
            self.value = self.nextItem!.value
            self.nextItem!.value = tmp
            return
        }
        
        //special case: 3 items, switch first and third values
        guard current.nextItem != nil else {
            let tmp = self.value
            self.value = current.value
            current.value = tmp
            return
        }
        
        //start with prev, current, next as indexes 1, 2, and 3
        let originalPrev = prev
        var next = current.nextItem
        
        //Reverse the middle n-2 items
        //Switch current's nextItem to prev
        //Then walk the chain forward one step
        repeat {
            current.nextItem = prev
            
            prev = current
            current = next!
            next = next?.nextItem
        } while (next != nil)
        
        //prev is now the original second-to-last item, the new second in the chain
        //Point self's nextItem pointer at it
        self.nextItem = prev
        
        //originalPrev is the original second item, the new second-to-last in the chain
        //current is the original last item
        //So point originalPrev's nextItem at current
        originalPrev.nextItem = current
        
        //Now switch the values of self (first item) and the original last item
        let tmp = self.value
        self.value = current.value
        current.value = tmp
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
