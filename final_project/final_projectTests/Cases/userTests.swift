//
//  userTests.swift
//  final_projectTests
//
//  Created by Adam Weintraut on 5/8/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import XCTest
@testable import final_project

class userTests: XCTestCase {

    override func setUp() {
        super.setUp()
        if(CoreDataHandler.cleanDeleteUser()){
            print("Successfully deleted All Users")
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        if(CoreDataHandler.cleanDeleteUser()){
            print("Successfully deleted All Users")
        }
    }
    
    func testValidUserSave() {
        XCTAssert(CoreDataHandler.saveUser(username: "username1", password: "password1", admin: false, firstName: "first1", lastName: "last1"),
                  "User was not saved successfully")
    }
    func testInvalidNilUserNameSave() {
        XCTAssertFalse(CoreDataHandler.saveUser(username: nil, password: "password1", admin: false, firstName: "first1", lastName: "last1"),
                  "User was saved with invalid value for username")
    }
    
    func testInvalidEmptyUserNameSave(){
        XCTAssertFalse(CoreDataHandler.saveUser(username: "", password: "password1", admin: false, firstName: "first1", lastName: "last1"),
                       "User was saved with empty value for username")
    }
    
    func testValidNumUserNameSave(){
        XCTAssert(CoreDataHandler.saveUser(username: "username1", password: "3345678", admin: false, firstName: "user1", lastName: "user1"),
                       "User was saved with invalid value for username")
    }
    
    func testNumUsers(){
        // values will be unused here, since we test for nil already
        _ = CoreDataHandler.saveUser(username: "username1", password: "password1", admin: true, firstName: "first1", lastName: "last1")
        _ = CoreDataHandler.saveUser(username: "username2", password: "password2", admin: false, firstName: "first2", lastName: "last2")
        _ = CoreDataHandler.saveUser(username: "username3", password: "password3", admin: false, firstName: "first3", lastName: "last3")
        _ = CoreDataHandler.saveUser(username: "username4", password: "password4", admin: false, firstName: "first4", lastName: "last4")
        
        let users = CoreDataHandler.fetchUser()
        XCTAssert(users?.count == 4, "Invalid Number of Users Saved")
    }
    
    func testFindUsers(){
        _ = CoreDataHandler.saveUser(username: "username1", password: "password1", admin: true, firstName: "first1", lastName: "last1")
        let user = CoreDataHandler.findUser(searchString: "username1")
        
        XCTAssert(user != nil && user?.username == "username1", "Correctly found user with specified username")
    }
    
    func testCleanDelete(){
        // Add 2 users
        _ = CoreDataHandler.saveUser(username: "username1", password: "password1", admin: true, firstName: "first1", lastName: "last1")
        _ = CoreDataHandler.saveUser(username: "username2", password: "password2", admin: false, firstName: "first2", lastName: "last2")
        // DELETE
        _ = CoreDataHandler.cleanDeleteUser()
        
        let users = CoreDataHandler.fetchUser()
        XCTAssert(users?.count == 0, "Did not fully delete")
        
    }
    
    func testDeleteOneUser(){
        _ = CoreDataHandler.saveUser(username: "username1", password: "password1", admin: true, firstName: "first1", lastName: "last1")
        let user = CoreDataHandler.findUser(searchString: "username1")
        
        _ = CoreDataHandler.deleteUser(user: user!)
        
        let users = CoreDataHandler.fetchUser()
        
        XCTAssert(CoreDataHandler.findUser(searchString: "username1") == nil && users?.count == 0, "Did not delete")
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
