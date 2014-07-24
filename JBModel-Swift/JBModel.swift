//
//  JBModel.swift
//  JBModel-Swift
//
//  Created by Jason Lee on 7/1/14.
//  Copyright (c) 2014 Jason Lee. All rights reserved.
//
//  Still very much a work in progress..
//
//

import Foundation


class JBModel: NSObject, NSCoding {
    
    var attributesMap: Dictionary<String, String> = [:]
    
    init(defaultAttributesMap: Dictionary<String,String>){
        self.attributesMap = defaultAttributesMap
    }
    
    func updateWithAttributes(attributes: Dictionary<String, AnyObject>!) {
        
        if (self.attributesMap.count == 0){
            let exception = NSException(name: NSInternalInconsistencyException, reason: "Your JBModel must define an attributesMap. These are usually key values that map json attribute names to class property names. See docs for more info.", userInfo: nil)
            exception.raise()
            return
        }
        
        // Setup the attributes index
        var attributesIndex:Array = []
        for var index=0; index < reflect(self).count; ++index {
            var key = reflect(self)[index].0
            if (key != "super") {
                attributesIndex.append(key)
            }
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

                        if propertyVal is Array<AnyObject> {

                            // Separate out the property name and the type included in the array
                            var className = propertyName![start...end]
                            // predecessor() makes sure we roll the index back one to lop off '<'
                            let finalPropertyName = p[p.startIndex...start.predecessor()]
                            
                            className = className.substringFromIndex(className.startIndex.successor())
                            className = className.substringToIndex(className.endIndex.predecessor())
                            
                            var array = Array<AnyObject>()
                            for dict in propertyVal as Array<AnyObject> {
                                
                                var anyobjectype : AnyObject.Type? = NSClassFromString(className)
                                if anyobjectype {
                                    var nsobjectype : NSObject.Type = anyobjectype! as NSObject.Type
                                    var object: AnyObject = nsobjectype()
                                    object.updateWithAttributes?(dict as Dictionary<String, AnyObject>)
                                    array.append(object)
                                }

                            }
                            setValue(array, forKey: finalPropertyName)
                            
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
    
    
}
