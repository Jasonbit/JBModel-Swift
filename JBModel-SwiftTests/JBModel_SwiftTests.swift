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

        let uid         = 125
        let fname       = "Bob"
        let lname       = "Jones"
        let phone       = "4155551212"
        let slug        = "1X53a"
        let gender      = "male"
        let dob         = "05/09/1980"
        let createdAt   = 1398226576 // 3.months.ago => Wed, 23 Apr 2014 04:16:21 UTC +00:00
        
        let friends     = [["first_name": "Alan", "last_name": "Kim", "user_id": 222], ["first_name": "Jim", "last_name": "Roberts", "user_id": 322]]
        
        let settings = ["email_me": "no", "refresh_interval": 10, "rating": 3.5]
        
        let bestFriend = ["first_name": "Mike", "last_name": "Smith", "user_id": 187]

        var user = User()
        user.updateWithAttributes(["user_id": uid, "first_name": fname, "last_name": lname, "phone": phone, "slug": slug, "gender": gender, "dob": dob, "created_at": createdAt, "friends": friends, "settings": settings, "best_friend": bestFriend])
        
//        println((dump(user)))
        
        // Object types
        XCTAssert(friends is Array<Dictionary<String, AnyObject>>, "friends is not an array")
        XCTAssert(settings is Dictionary<String, AnyObject>, "settings is not a dictionary")
        XCTAssert(bestFriend is Dictionary<String, AnyObject>, "bestFriend is not a dictionary")
        
        // Basic properties
        XCTAssert(user.id           == uid,         "user id != \(uid)")
        XCTAssert(user.firstName    == fname,       "user firstName != \(fname)")
        XCTAssert(user.lastName     == lname,       "user lastName != \(lname)")
        XCTAssert(user.phone        == phone,       "user phone != \(phone)")
        XCTAssert(user.slug         == slug,        "user slug != \(slug)")
        XCTAssert(user.gender       == gender,      "user gender != \(gender)")
        XCTAssert(user.dob          == dob,         "user dob != \(dob)")
        XCTAssert(user.createdAt    == createdAt,   "user createdAt != \(createdAt)")
        
        // Related objects
        XCTAssertNotNil(user.bestFriend, "user.bestFriend is nil")
        
        // Collections
        XCTAssert(user.friends?.count == 2, "user friends count != 2")
        XCTAssert(user.settings?.keys.array.count == 3, "user settings count != 3")
    }
    
}
