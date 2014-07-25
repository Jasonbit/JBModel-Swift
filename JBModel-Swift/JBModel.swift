//
//  JBModel.swift
//  JBModel-Swift
//
//  Created by Jason Lee on 7/1/14.
//  Copyright (c) 2014 Jason Lee. All rights reserved.
//
//  Still very much a work in progress..
//
//  Here's the gist behind this.
//
//  I have an Obj-C version of this that works and has been in a few production apps that have
//  all be accepted in the App Store. The Obj-C version has probably de/serialized millions of
//  models. So I know it works on that side. This is my stab at a Swift version since I want
//  to use it my current projects.
//
//  
//
//

import Foundation


class JBModel: NSObject, NSCoding {
    
    var attributesMap: Dictionary<String, String> = [:]
    
    init(defaultAttributesMap: Dictionary<String,String>){
        self.attributesMap = defaultAttributesMap
    }
    
    //
    // Yes, this function will be getting a lot of refactoring and cleanup
    //
    func updateWithAttributes(attributes: Dictionary<String, AnyObject>!) {
        
        if (self.attributesMap.count == 0){
            let exception = NSException(name: NSInternalInconsistencyException, reason: "Your JBModel must define an attributesMap. These are usually key values that map json attribute names to class property names. See docs for more info.", userInfo: nil)
            exception.raise()
            return
        }
        
        // Iterate over attributes k/v and set
        for key in attributes.keys {

            var propertyName:String?     = attributesMap[key]
            var propertyVal: AnyObject?  = attributes[key]
            
            if propertyName && propertyVal {
                let p = propertyName!

                // Haven't yet found the best way to match up multiple optionals like this on a 
                // single line. Dunno if it's even possible..
                if let start = find(p.lowercaseString, "<") {
                    if  let end = find(p.lowercaseString, ">") {

                        // We should have, for ex, the class name - User - and property name - bestFriend - teased out of bestFriend<User>
                        let classPropertyname = getClassAndPropertyName(p, start: start, end: end)
                        
                        // Check if our property is an array of <SomeModel>
                        if propertyVal is Array<AnyObject> {

                            var array = Array<AnyObject>()
                            for dict in propertyVal as Array<AnyObject> {
                                
                                // Credit for the following code: http://stackoverflow.com/questions/24030814/swift-language-nsclassfromstring#answer-24524077
                                var anyobjectype : AnyObject.Type? = NSClassFromString(classPropertyname.className)
                                if anyobjectype {
                                    var nsobjectype : NSObject.Type = anyobjectype! as NSObject.Type
                                    var object: AnyObject = nsobjectype()
                                    object.updateWithAttributes?(dict as Dictionary<String, AnyObject>)
                                    array.append(object)
                                }

                            }
                            
                            // Once we're out of the array making, set it to the model property
                            setValue(array, forKey: classPropertyname.finalPropertyName)
                            
                        } else {
                            println("propertyVal \(propertyVal) is not an array and it needs to be if you are specifying a class type in the mapping")
                        }

                    }
                    
                } else {
                    
                    setValue(propertyVal!, forKey: propertyName!)
                    
                }
            }
            
        }
        
    }
    
    
    // NSCoding methods
    
    init(coder decoder: NSCoder!) {
        println("init coder")
        
    }
    
    func encodeWithCoder(encoder: NSCoder!) {
        println("nscodign encode")
        
    }
    
    func decodeWithCoder(encoder: NSCoder!) {
        println("nscodign decode")
        
    }
    
    
    // Util methods
    
    func getClassAndPropertyName(propertyName: String, start: String.Index, end: String.Index) -> (className: String, finalPropertyName: String) {
        
        // Separate out the property name and the type included in the array
        var className = propertyName[start...end]
        // predecessor() makes sure we roll the index back one to lop off '<'
        let finalPropertyName = propertyName[propertyName.startIndex...start.predecessor()]
        
        className = className.substringFromIndex(className.startIndex.successor())
        className = className.substringToIndex(className.endIndex.predecessor())
        
        return (className, finalPropertyName)
        
    }
    
}
