//
//  noteTests.swift
//  final_projectTests
//
//  Created by Adam Weintraut on 5/10/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//
import XCTest
@testable import final_project

class noteTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        if(CoreDataHandler.cleanDeleteNote()){
            print("Successfully deleted All Notes")
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        if(CoreDataHandler.cleanDeleteNote()){
            print("Successfully deleted All Notes")
        }
    }
    
    func testValidNoteSave() {
        
        XCTAssert(CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1"))
    }
    
    func testInvalidNilNoteSave() {
        XCTAssertFalse(CoreDataHandler.saveNote(title: nil, date: Date(), details: "This is Note1"))
    }
    
    func testInvalidEmptyNoteSave(){
        XCTAssertFalse(CoreDataHandler.saveNote(title: "", date: Date(), details: "This is Note1"))
    }
    
    func testValidNumNoteSave(){
        XCTAssert(CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1"))
    }
    
    func testNumNotes(){
        // values will be unused here, since we test for nil already
        _ = CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1")
        _ = CoreDataHandler.saveNote(title: "Note2", date: Date(), details: "This is Note2")
        _ = CoreDataHandler.saveNote(title: "Note3", date: Date(), details: "This is Note3")
        _ = CoreDataHandler.saveNote(title: "Note4", date: Date(), details: "This is Note4")
        
        let notes = CoreDataHandler.fetchNote()
        XCTAssert(notes?.count == 4, "Invalid Number of Notes Saved")
    }
    
    func testFindNotes(){
        _ = CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1")
        _ = CoreDataHandler.saveNote(title: "Note2", date: Date(), details: "This is Note2")
        let note = CoreDataHandler.findNote(searchString: "Note1")
        
        XCTAssert(note != nil && note?.title == "Note1", "Correctly found Note with specified name")
    }
    
    
    func testCleanDelete(){
        // Add 2 users
        _ = CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1")
        _ = CoreDataHandler.saveNote(title: "Note2", date: Date(), details: "This is Note2")
        // DELETE
        _ = CoreDataHandler.cleanDeleteNote()
        
        let notes = CoreDataHandler.fetchNote()
        XCTAssert(notes?.count == 0, "Did not fully delete")
        
    }
    
    func testDeleteOneNote(){
        _ = CoreDataHandler.saveNote(title: "Note1", date: Date(), details: "This is Note1")
        let note = CoreDataHandler.findNote(searchString: "Note1")
        
        _ = CoreDataHandler.deleteNote(note: note!)
        
        let notes = CoreDataHandler.fetchNote()
        
        XCTAssert(CoreDataHandler.findNote(searchString: "Note1") == nil && notes?.count == 0, "Did not delete")
        
    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
