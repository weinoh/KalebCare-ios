//
//  final_projectUITests.swift
//  final_projectUITests
//
//  Created by Adam Weintraut on 4/23/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import XCTest
@testable import final_project

class final_projectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        _ = CoreDataHandler.cleanDeleteMed()
        _ = CoreDataHandler.cleanDeleteTimesheet()
        _ = CoreDataHandler.cleanDeleteNote()
        _ = CoreDataHandler.cleanDeleteUser()
        _ = CoreDataHandler.cleanDeleteTask()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        _ = CoreDataHandler.cleanDeleteMed()
        _ = CoreDataHandler.cleanDeleteTimesheet()
        _ = CoreDataHandler.cleanDeleteNote()
        _ = CoreDataHandler.cleanDeleteUser()
        _ = CoreDataHandler.cleanDeleteTask()

        super.tearDown()
    }
    
    func testRegistrationEnter() {
        // Use recording to get started writing UI tests.
                        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRegistrationCancel(){
        // Use recording to get started writing UI tests.
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
