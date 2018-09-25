//
//  timesheetTests.swift
//  final_projectTests
//
//  Created by Adam Weintraut on 5/10/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import XCTest
@testable import final_project

class timesheetTests: XCTestCase {
    var user1:User?
    override func setUp() {
        super.setUp()
        if(CoreDataHandler.cleanDeleteTimesheet()){
            print("Successfully deleted All Timesheets")
        }
        _ = CoreDataHandler.saveUser(username: "username1", password: "password1", admin: false, firstName: "first1", lastName: "last1")
        user1 = CoreDataHandler.findUser(searchString: "username1")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        if(CoreDataHandler.cleanDeleteTimesheet()){
            print("Successfully deleted All Timesheets")
        }
        if(CoreDataHandler.cleanDeleteUser()){
            print("Successfully deleted All Users")
        }
    }
    
    func testValidTimesheetSave() {
        XCTAssert(CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date: Date()))
    }
    
    func testInvalidNilTimesheetSave() {
        XCTAssertFalse( CoreDataHandler.saveTimesheet(user: nil, numHours: 1, date: Date()))
    }
    
    func testInvalidEmptyTimesheetSave(){
        XCTAssertFalse(CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date:nil))
    }
    
    
    func testNumTimesheets(){
            // values will be unused here, since we test for nil already
         _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date: Date())
         _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 2, date: Date())
         _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 3, date: Date())
         _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 4, date: Date())
        
        
        let timesheets = CoreDataHandler.fetchTimesheet()
        XCTAssert(timesheets?.count == 4, "Invalid Number of Tasks Saved")
    }
    
    func testUserTimesheets(){
        // values will be unused here, since we test for nil already
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date: Date())
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 2, date: Date())
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 3, date: Date())
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 4, date: Date())
        
        let timesheet = user1?.timesheet
        XCTAssert(timesheet?.count == 4, "Invalid Number of Tasks Saved For 1 User")
    }
    
    
    func testCleanDelete(){
        // Add 2 timesheets
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date: Date())
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 2, date: Date())
        // DELETE
        _ = CoreDataHandler.cleanDeleteTimesheet()
        
        let timesheets = CoreDataHandler.fetchTimesheet()
        XCTAssert(timesheets?.count == 0, "Did not fully delete")
        
    }
    
    func testDeleteUserCascade(){
        // Add 2 timesheets
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 1, date: Date())
        _ = CoreDataHandler.saveTimesheet(user: user1, numHours: 2, date: Date())
        
        _ = CoreDataHandler.deleteUser(user: user1!)
        
        let timesheets = CoreDataHandler.fetchTimesheet()
        
        XCTAssert(timesheets?.count == 0, "Did not delete")
        
    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
