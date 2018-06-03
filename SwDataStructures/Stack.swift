//
//  Stack.swift
//  SwDataStructures
//
//  Created by Anindya Nandi on 27/05/18.
//  Copyright © 2018 Anindya Nandi. All rights reserved.
//

private class StackItem<Element> {
    
    fileprivate var value:Element
    fileprivate var next:StackItem?
    fileprivate weak var previous:StackItem?
    
    fileprivate init( _ value:Element) {
        self.value = value
    }
}

public struct Stack<Element> {

    private var head: StackItem<Element>?
    private var tail: StackItem<Element>?
    private var count = 0
    
    public init(){ }
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == Element {
        
        for element in elements {
            push(element)
        }
    }
    
    /**
     This variable returns the size of the stack
     */
    public var size:Int {
        get{
            return count
        }
    }
    
    /**
     This variable returns true if the stack is empty,
     else returns false
     */
    public var isEmpty:Bool {
        get{
            return head == nil
        }
    }
    
    /**
     This variable returns top item from the stack,
     returns nil if stack is empty
     */
    public var topItem:Element? {
        get{
            
            if let lastItem = tail {
                
                return lastItem.value
            }
            
            return nil
        }
    }
    
    /**
     This function pushes an item in the Stack.
     - Parameter item : The item to be pushed
     - Returns        : No return value
     */
    public mutating func push( _ item:Element) {
        
        let newItem = StackItem(item)
        //check if tail node is empty
        if let tailNode = tail {
            //list non-empty
            //adjust pointers
            newItem.previous = tailNode
            tailNode.next = newItem
        }
        else {
            //empty list, make this head
            head = newItem
        }
        //mark new added element as tail
        tail = newItem
        count += 1
    }
    
    /**
     This function pops an item from the Stack.
     - Parameter item : The item to be popped
     - Returns        : Optional item type
     */
    public mutating func pop() ->Element? {
        
        //returns an optional element type, nil if stack is empty
        if self.isEmpty == false  {
            
            let lastElement = tail
            tail = tail?.previous
            tail?.next = nil
            count -= 1
            
            return lastElement?.value
        }
        
        return nil
    }
    
    /**
     This function removes all item from the Stack.
     */
    public mutating func clear() {
        
        head = nil
        tail = nil
        count = 0
    }
}

extension Stack:CustomStringConvertible {
    
    public var description : String {
        
        var text = ""
        var item = head
        
        while item != nil {
            text += "\(item!.value)"
            item = item!.next
            if item != nil {
                text += "\n"
            }
        }
        return text
    }
    
}
