//
//  JBModel_SwiftTests.swift
//  JBModel-SwiftTests
//
//  Created by Jason Lee on 7/1/14.
//  Copyright (c) 2014 Jason Lee. All rights reserved.
//

import UIKit
import XCTest

class JBModel_SwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSerialization() {
        // This is an example of a functional test case.
        var user = User()
        user.updateWithAttributes(["user_id": 145, "first_name":"Bob"])
        
        //        println((dump(user)))
        
        XCTAssert(user.id == 145, "user id != 145")
        XCTAssert(user.firstName == "Bob", "user firstName != Bob")
        
    }
    
}
