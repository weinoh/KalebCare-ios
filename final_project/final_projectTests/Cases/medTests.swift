//
//  medTests.swift
//  final_projectTests
//
//  Created by Adam Weintraut on 5/10/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import XCTest
@testable import final_project

class medTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        if(CoreDataHandler.cleanDeleteMed()){
            print("Successfully deleted All Meds")
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        if(CoreDataHandler.cleanDeleteMed()){
            print("Successfully deleted All Meds")
        }
    }
    
    func testValidMedSave() {

        XCTAssert(CoreDataHandler.saveMed(name: "Med1", dose: "20mg", details: "This is Med1"),
                  "Med was not saved successfully")
    }
    
    func testInvalidNilMedSave() {
        XCTAssertFalse(CoreDataHandler.saveMed(name: nil, dose: "20mg", details: "This is Med1"),
                       "Med was saved with invalid value for name")
    }
    
    func testInvalidEmptyMedSave(){
        XCTAssertFalse(CoreDataHandler.saveMed(name: "", dose: "20mg", details: "This is Med1"),
                       "Med was saved with invalid value for name")
    }
    
    func testValidNumMedSave(){
        XCTAssert(CoreDataHandler.saveMed(name: "123456", dose: "20mg", details: "This is Med1"),
                  "Med was not saved successfully")
    }
    
    func testNumMeds(){
        // values will be unused here, since we test for nil already
        _ = CoreDataHandler.saveMed(name: "Med1", dose: "20mg", details: "This is Med1")
        _ = CoreDataHandler.saveMed(name: "Med2", dose: "20mg", details: "This is Med2")
        _ = CoreDataHandler.saveMed(name: "Med3", dose: "20mg", details: "This is Med3")
        _ = CoreDataHandler.saveMed(name: "Med4", dose: "20mg", details: "This is Med4")
        
        let meds = CoreDataHandler.fetchMed()
        XCTAssert(meds?.count == 4, "Invalid Number of Meds Saved")
    }
    
    func testFindMeds(){
        _ = CoreDataHandler.saveMed(name: "Med1", dose: "20mg", details: "This is Med1")
        _ = CoreDataHandler.saveMed(name: "Med2", dose: "20mg", details: "This is Med2")
        let med = CoreDataHandler.findMed(searchString: "Med1")
        
        XCTAssert(med != nil && med?.name == "Med1", "Correctly found med with specified name")
    }
    
    
    func testCleanDelete(){
        // Add 2 users
        _ = CoreDataHandler.saveMed(name: "Med1", dose: "20mg", details: "This is Med1")
        _ = CoreDataHandler.saveMed(name: "Med2", dose: "20mg", details: "This is Med2")
        // DELETE
        _ = CoreDataHandler.cleanDeleteMed()
        
        let meds = CoreDataHandler.fetchMed()
        XCTAssert(meds?.count == 0, "Did not fully delete")
        
    }
    
    func testDeleteOneMed(){
        _ = CoreDataHandler.saveMed(name: "Med1", dose: "20mg", details: "This is Med1")
        let med = CoreDataHandler.findMed(searchString: "Med1")
        
        _ = CoreDataHandler.deleteMed(med: med!)
        
        let meds = CoreDataHandler.fetchMed()
        
        XCTAssert(CoreDataHandler.findMed(searchString: "Med1") == nil && meds?.count == 0, "Did not delete")
        
    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
