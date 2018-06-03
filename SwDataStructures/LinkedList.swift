//
//  LinkedList.swift
//  SwDataStructures
//
//  Created by Anindya Nandi on 27/05/18.
//  Copyright © 2018 Anindya Nandi. All rights reserved.

public class Node<Element> {
    
    public var value:Element
    public var next:Node?
    public weak var previous:Node?
    
    init(value:Element) {
        self.value = value
    }
}

extension Node:Equatable where Element:Equatable {
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        
        return lhs.value == rhs.value
    }
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        
        return "[\(self.value)]"
    }
}



public struct LinkedList<Element:Equatable> {
    
    private var head: Node<Element>?
    private var tail: Node<Element>?
    private var itemCount = 0
    
    public init() {}
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == Element {
        
        for element in elements {
            append(element)
        }
    }
    
    public var count:Int {
        get {
            return itemCount
        }
    }
    
    public var isEmpty: Bool {
        get {
            return head == nil
        }
    }
    
    public var first: Element? {
        get {
            return head?.value
        }
    }
    
    public var last: Element? {
        get {
            return tail?.value
        }
    }
    
    /**
     This function adds a new item to the linked list. The new item is added at the very end.
     - Parameter item: The item to be added
     - Returns       : No return value
     */
    public mutating func append( _ value:Element) {
        
        let newNode = Node(value: value)
        //check if tail node is empty
        if let tailNode = tail {
            //list non-empty
            //adjust pointers
            newNode.previous = tailNode
            tailNode.next = newNode
        }
        else {
            //empty list, make this head
            head = newNode
        }
        //mark new added element as tail
        tail = newNode
        
        //increment global counter
        itemCount += 1
    }
    
    /**
     This function adds a new item to the linked list at a given index.
     - Parameter item: The item to be added
     - Parameter index: The index where the ietm is to be added
     - Returns       : Boolean.True if insertion was successful else false.
     */
    public mutating func insertItem(_ item:Element, atIndex index:Int) -> Bool {
        
        let newNode = Node(value: item)
        let nextNode = nodeAt(index: index)
        let previousNode = nextNode?.previous
        
        guard previousNode != nil || nextNode != nil else {
            return false
        }
        
        if previousNode == nil {
            //head node
            head = newNode
            newNode.next = nextNode
            itemCount += 1
            return true
        }
        
        newNode.previous = previousNode
        previousNode?.next = newNode
        newNode.next = nextNode
        nextNode?.previous = newNode
        itemCount += 1
        return true
    }
 
    
    /**
     This function returns a node at an index.If the index is invalid, then this fuction returns nil.
     
     - Parameter index: The index of the node to be returned
     - Returns        : Optional node
     */
    public func itemAt( _ index: Int) -> Element? {
        
        if let node = nodeAt(index: index) {
            
            return node.value
        }
        
        return nil
    }
    
    private func nodeAt(index: Int) -> Node<Element>? {
        
        var node = head
        var idx = 0
        
        while node != nil {
            
            if idx == index {
                
                return node
            }
            
            node = node?.next
            idx += 1
        }
        
        return nil
    }
    
    /**
     This function removes all items from the linked list.
     */
    public mutating func removeAll() {
        head = nil
        tail = nil
        itemCount = 0
    }
    
    /**
     This function removes a node matching the value provided in the argument.
     
     - Parameter item : The item to be removed
     - Returns        : Bool value. True if removal is successful else false.
     */
    public mutating func removeItem( _ item:Element) -> Bool {
        
        let node = nodeForElement(element: item)
        guard node != nil else {
            
            return false
        }
        
        let next = node!.next
        let previous = node!.previous
        
        if next == nil {
            //tail node
            tail = node!.previous
            node!.previous = nil
            previous?.next = nil
            itemCount -= 1
            return true
        }
        
        if previous == nil {
            //head node
            head = node!.next
            next?.previous = nil
            node!.next = nil
            head = next
            itemCount -= 1
            return true
        }
        
        next?.previous = previous
        previous?.next = next
        node!.previous = nil
        node!.next = nil
        itemCount -= 1
        return true
        
    }
    
    private func nodeForElement(element: Element) -> Node<Element>? {
        
        var node = head
        
        while node != nil {
            
            if node?.value == element {
                
                return node
            }
            
            node = node?.next
        }
        
        return nil
    }
    
    /**
     This function reverses the linked list.
     */
    public mutating func reverse() {
        
        var node = head
        tail = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
    
    public subscript(index: Int) -> Element? {
        
        return itemAt(index)
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        
        var text = ""
        var node = head
        
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil {
                text += " -> "
            }
        }
        return text
    }
}

public class LinkedListIterator<Element>:IteratorProtocol {
    
    private var currentNode: Node<Element>?
    
    init(startNode: Node<Element>?) {
        currentNode = startNode
    }
    
    public func next() -> Node<Element>? {
        
        let node = currentNode
        currentNode = currentNode?.next
        
        return node
        
    }
}

extension LinkedList: Sequence {
    
    public typealias listIterator = LinkedListIterator<Element>
    
    public func makeIterator() -> LinkedList.listIterator {
        return LinkedListIterator(startNode: head)
    }
}
