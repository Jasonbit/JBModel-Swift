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


let kAttrUserId     = "user_id"
let kAttrFirstName  = "first_name"
let kAttrLastName   = "last_name"
let kAttrPhone      = "phone"
let kAttrSlug       = "slug"
let kAttrGender     = "gender"
let kAttrDob        = "dob"
let kAttrCreatedAt  = "created_at"
let kAttrFriends    = "friends"
let kAttrSettings   = "settings"
let kAttrBestFriend = "best_friend"


@objc(User) class User: JBModel {
    
    
    var id:         Int     = Int()
    var firstName:  String?
    var lastName:   String?
    var phone:      String?
    var slug:       String?
    var gender:     String?
    var dob:        String?
    var createdAt:  Int     = Int()
    var friends:    Array<User>?
    var settings:   Dictionary<String, AnyObject>?
    var bestFriend: User?
    
    
    convenience init() {
        
        self.init(defaultAttributesMap: [
            kAttrUserId:        "id",
            kAttrFirstName:     "firstName",
            kAttrLastName:      "lastName",
            kAttrPhone:         "phone",
            kAttrSlug:          "slug",
            kAttrGender:        "gender",
            kAttrDob:           "dob",
            kAttrCreatedAt:     "createdAt",
            kAttrFriends:       "friends<User>",
            kAttrSettings:      "settings",
            kAttrBestFriend:    "bestFriend"
            ])
    }
    
    init(defaultAttributesMap: Dictionary<String,String>){
        super.init(defaultAttributesMap: defaultAttributesMap)
    }
    
    init( coder decoder : NSCoder!) {
        
        id          = decoder.decodeObjectForKey(kAttrUserId) as Int
        firstName   = decoder.decodeObjectForKey(kAttrFirstName) as? String
        lastName    = decoder.decodeObjectForKey(kAttrLastName) as? String
        phone       = decoder.decodeObjectForKey(kAttrPhone) as? String
        slug        = decoder.decodeObjectForKey(kAttrSlug) as? String
        gender      = decoder.decodeObjectForKey(kAttrGender) as? String
        dob         = decoder.decodeObjectForKey(kAttrDob) as? String
        createdAt   = decoder.decodeObjectForKey(kAttrCreatedAt) as Int
        friends     = decoder.decodeObjectForKey(kAttrDob) as? Array
        settings    = decoder.decodeObjectForKey(kAttrDob) as? Dictionary
        bestFriend  = decoder.decodeObjectForKey(kAttrBestFriend) as? User
        
        super.init(coder: decoder)
        
    }
    
    override func encodeWithCoder( encoder: NSCoder!) {
        
        encoder.encodeObject(id,            forKey:kAttrUserId)
        encoder.encodeObject(firstName,     forKey:kAttrFirstName)
        encoder.encodeObject(lastName,      forKey:kAttrLastName)
        encoder.encodeObject(phone,         forKey:kAttrPhone)
        encoder.encodeObject(slug,          forKey:kAttrSlug)
        encoder.encodeObject(gender,        forKey:kAttrGender)
        encoder.encodeObject(dob,           forKey:kAttrDob)
        encoder.encodeObject(createdAt,     forKey:kAttrCreatedAt)
        encoder.encodeObject(friends,       forKey:kAttrFriends)
        encoder.encodeObject(settings,      forKey:kAttrSettings)
        encoder.encodeObject(bestFriend,    forKey:kAttrBestFriend)
        
    }
    
}
