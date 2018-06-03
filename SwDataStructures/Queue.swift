//
//  Queue.swift
//  SwDataStructures
//
//  Created by Anindya Nandi on 27/05/18.
//  Copyright © 2018 Anindya Nandi. All rights reserved.

private class QueueItem<Element> {
    
    fileprivate var value:Element
    fileprivate var next:QueueItem?
    fileprivate weak var previous:QueueItem?
    
    fileprivate init( _ value:Element) {
        self.value = value
    }
}

public struct Queue<Element> {
    
    private var head: QueueItem<Element>?
    private var tail: QueueItem<Element>?
    private var count = 0
    
    public init(){ }
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == Element {
        
        for element in elements {
            enQueue(element)
        }
    }
    
    /**
     This variable returns the size of the queue
     */
    public var size:Int {
        get{
            return count
        }
    }
    
    /**
     This variable returns true if the queue is empty,
     else returns false
     */
    public var isEmpty:Bool {
        get{
            return head == nil
        }
    }
    
    /**
     This function adds an item to the end of the Queue
     - Parameter item: The item to be enqueued
     - Returns       : No return value
     */
    public mutating func enQueue( _ item:Element) {
        
        let newItem = QueueItem(item)
        //check if tail node is empty
        if let tailItem = tail {
            //list non-empty
            //adjust pointers
            newItem.previous = tailItem
            tailItem.next = newItem
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
     This function removes an item from the front of teh Queue.
     - Parameter item: The item to be dequeued
     - Returns       : Optional item type
     */
    public mutating func deQueue() -> Element? {
        
        if self.isEmpty == false {
            
            let firstElement = head
            head = head?.next
            head?.previous = nil
            count -= 1
            
            return firstElement?.value
        }
        
        return nil
    }
    
    /**
     This function returns the item at the front of the queue without removing it.
     - Returns       : Optional item type
     */
    public mutating func peek() -> Element? {
        
        if self.isEmpty == false {
            return head?.value
        }
        
        return nil
    }
    
    /**
     This function removes all item from the Queue.
     */
    public mutating func clear() {
        
        head = nil
        tail = nil
        count = 0
    }
}

extension Queue: CustomStringConvertible {
    
    public var description : String {
        
        var text = ""
        var item = head
        
        while item != nil {
            text += "\(item!.value)"
            item = item!.next
            if item != nil {
                text += ","
            }
        }
        return text
    }
}
