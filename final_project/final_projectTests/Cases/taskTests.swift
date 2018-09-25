//
//  taskTests.swift
//  final_projectTests
//
//  Created by Adam Weintraut on 5/10/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import XCTest
@testable import final_project

class taskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        if(CoreDataHandler.cleanDeleteTask()){
            print("Successfully deleted All Notes")
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        if(CoreDataHandler.cleanDeleteTask()){
            print("Successfully deleted All Notes")
        }
    }
    
    func testValidTaskSave() {
        XCTAssert(CoreDataHandler.saveTask(name: "Task1", time: "10:00 am", details: "This is Task1", done: false))
    }
    
    func testInvalidNilTaskSave() {
        XCTAssertFalse( CoreDataHandler.saveTask(name: nil, time: "10:00 am", details: "This is Task1", done: false))
    }
    
    func testInvalidEmptyTaskSave(){
        XCTAssertFalse( CoreDataHandler.saveTask(name: "", time: "10:00 am", details: "This is Task1", done: false))
    }
    
    func testValidNumTaskSave(){
        XCTAssert(CoreDataHandler.saveTask(name: "123456", time: "10:00 am", details: "This is Task1", done: false))
    }
    
    func testNumTasks(){
        // values will be unused here, since we test for nil already
        _ = CoreDataHandler.saveTask(name: "Task1", time: "10:00 am", details: "This is Task1", done: false)
        _ = CoreDataHandler.saveTask(name: "Task2", time: "10:00 am", details: "This is Task2", done: false)
        _ = CoreDataHandler.saveTask(name: "Task3", time: "10:00 am", details: "This is Task3", done: false)
        _ = CoreDataHandler.saveTask(name: "Task4", time: "10:00 am", details: "This is Task4", done: false)
        
        let tasks = CoreDataHandler.fetchTask()
        XCTAssert(tasks?.count == 4, "Invalid Number of Tasks Saved")
    }
    
    func testFindTasks(){
        _ = CoreDataHandler.saveTask(name: "Task1", time: "10:00 am", details: "This is Task1", done: false)
        _ = CoreDataHandler.saveTask(name: "Task2", time: "10:00 am", details: "This is Task2", done: false)
        let task = CoreDataHandler.findTask(searchString: "Task1")
        
        XCTAssert(task != nil && task?.name == "Task1", "Correctly found Task with specified name")
    }
    
    
    func testCleanDelete(){
        // Add 2 users
        _ = CoreDataHandler.saveTask(name: "Task1", time: "10:00 am", details: "This is Task1", done: false)
        _ = CoreDataHandler.saveTask(name: "Task2", time: "10:00 am", details: "This is Task2", done: false)
        // DELETE
        _ = CoreDataHandler.cleanDeleteTask()
        
        let tasks = CoreDataHandler.fetchTask()
        XCTAssert(tasks?.count == 0, "Did not fully delete")
        
    }
    
    func testDeleteOneNote(){
        _ = CoreDataHandler.saveTask(name: "Task1", time: "10:00 am", details: "This is Task1", done: false)
        let task = CoreDataHandler.findTask(searchString: "Task1")
        
        _ = CoreDataHandler.deleteTask(task: task!)
        
        let tasks = CoreDataHandler.fetchTask()
        
        XCTAssert(CoreDataHandler.findTask(searchString: "Task1") == nil && tasks?.count == 0, "Did not delete")
        
    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
