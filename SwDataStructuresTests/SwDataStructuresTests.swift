//
//  SwDataStructuresTests.swift
//  SwDataStructuresTests
//
//  Created by Anindya Nandi on 27/05/18.
//  Copyright © 2018 Anindya Nandi. All rights reserved.
//

import XCTest
@testable import SwDataStructures

class SwDataStructuresTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLinkedList() {
        
        var stringLinkedList = LinkedList<String>()
        
        //test isEmpty
        XCTAssertTrue(stringLinkedList.isEmpty)
        
        stringLinkedList.append("One")
        stringLinkedList.append("Two")
        stringLinkedList.append("Three")
        stringLinkedList.append("Four")
        stringLinkedList.append("Five")
        
        //test isEmpty
        XCTAssertFalse(stringLinkedList.isEmpty)
        
        //test count, first, last , nodeAt() and subscript
        XCTAssertEqual(stringLinkedList.count, 5, "The count for linked list is invalid")
        XCTAssertEqual(stringLinkedList.first, "One", "The First value of linked list is invalid")
        XCTAssertEqual(stringLinkedList.last, "Five", "The Last value of linked list is invalid")
        XCTAssertEqual(stringLinkedList.itemAt(4), "Five", "The index value of linked list is invalid")
        XCTAssertEqual(stringLinkedList[2], "Three", "The subscript value of linked list is invalid")
        
        //test removeItem() function
        XCTAssertTrue(stringLinkedList.removeItem("Three"))
        XCTAssertFalse(stringLinkedList.removeItem("Six"))
        XCTAssertEqual(stringLinkedList.first, "One", "")
        XCTAssertEqual(stringLinkedList.last, "Five", "")
        
        //test reverse function
        stringLinkedList.reverse()
        XCTAssertEqual(stringLinkedList.first, "Five", "The reverse function of linked list is not working as expected")
        XCTAssertEqual(stringLinkedList.last, "One", "The reverse function of linked list is not working as expected")
        
        //test removeAll() function
        stringLinkedList.removeAll()
        XCTAssertTrue(stringLinkedList.isEmpty)
        
        //test insertAt() function
        stringLinkedList.append("One")
        stringLinkedList.append("Two")
        stringLinkedList.append("Three")
        
        //insert at the begining
        XCTAssertTrue(stringLinkedList.insertItem("test", atIndex: 0))
        XCTAssertEqual(stringLinkedList.count, 4, "The count for linked list is invalid")
        XCTAssertEqual(stringLinkedList.first, "test", "The First value of linked list is invalid")
        XCTAssertEqual(stringLinkedList.last, "Three", "The Last value of linked list is invalid")
        
        
    }
    
    func testStack() {
        
        var stringStack = Stack<String>()
        
        XCTAssertTrue(stringStack.isEmpty)
        
        stringStack.push("one")
        stringStack.push("two")
        stringStack.push("three")
        stringStack.push("four")
        
        XCTAssertFalse(stringStack.isEmpty)
        XCTAssertEqual(stringStack.size, 4, "The size of stack is invalid")
        XCTAssertEqual(stringStack.topItem, "four", "The top item of stack invalid")
        XCTAssertEqual(stringStack.pop(), "four", "The popped item from stack invalid")
        
        stringStack.clear()
        
        XCTAssertEqual(stringStack.size, 0, "The size of stack is invalid")
        XCTAssertEqual(stringStack.topItem, nil, "The size of stack is invalid")
        XCTAssertEqual(stringStack.pop(), nil, "The popped item from stack invalid")
        
    }
    
    func testPerformanceStack() {
        
        var stringStack = Stack<String>()
        
        self.measure {
            stringStack.push("one")
             _ = stringStack.pop()
        }
    }
    
    
    func testQueue() {
        
        var stringQueue = Queue<String>()
        
        XCTAssertTrue(stringQueue.isEmpty)
        
        stringQueue.enQueue("one")
        stringQueue.enQueue("two")
        stringQueue.enQueue("three")
        stringQueue.enQueue("four")
        
        XCTAssertFalse(stringQueue.isEmpty)
        XCTAssertEqual(stringQueue.size, 4, "The size of queue is invalid")
        XCTAssertEqual(stringQueue.peek(), "one", "The peek value of queue is invalid")
        XCTAssertEqual(stringQueue.size, 4, "The size of queue is invalid")
        XCTAssertEqual(stringQueue.deQueue(),"one", "The dequeued object is incorrect")
        XCTAssertEqual(stringQueue.size, 3, "The size of queue is invalid")
        
        stringQueue.clear()
        XCTAssertEqual(stringQueue.size, 0, "The size of queue is invalid")
        XCTAssertEqual(stringQueue.peek(), nil, "The peek value of the queue is invalid")
        XCTAssertEqual(stringQueue.deQueue(), nil, "The dequeued item from queue is invalid")
        
        
    }
    
    func testPerformanceQueue() {
        
        var stringQueue = Queue<String>()
        
        self.measure {
            stringQueue.enQueue("one")
            _ = stringQueue.deQueue()
            stringQueue.clear()
            
        }
    }
    
}
