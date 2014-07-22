//
//  User.swift
//  JBModel-Swift
//
//  Created by Jason Lee on 7/1/14.
//  Copyright (c) 2014 Jason Lee. All rights reserved.
//
//  Appears to be a crash in the Foundation framework when
//  super class tries to set an Int on a property that has not
//  been initialized. This is obviously not fun because there 
//  would need to be a lot of boiler plate code to init *every*
//  property for every model. The Obj-C version of this doesn't
//  have this issue. So the hack around it for now is to initialize
//  any Ints (I supsect this will be the case for any numerics).
//  Strings do not have this issue.

import Foundation


class User: JBModel {
    
    
    var id:         Int     = Int()
    var firstName:  String?
    var lastName:   String?
    var phone:      String?
    
//    override class func accessInstanceVariablesDirectly() -> Bool {
//        return true
//    }
    
    convenience init() {
        
        self.init(defaultAttributesMap: [
            "id":           "user_id",
            "firstName":    "first_name",
            "lastName":     "last_name",
            "phone":        "phone"
            ])
    }
    
    init(defaultAttributesMap: Dictionary<String,String>){
        super.init(defaultAttributesMap: defaultAttributesMap)
    }
    
}
