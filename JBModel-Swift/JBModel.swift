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
        //      println(reflect(self)[index].0 + ": "+reflect(self)[index].1.summary)
        var attributesIndex:Array = []
        for var index=0; index < reflect(self).count; ++index {
            var key = reflect(self)[index].0
            if (key != "super") {
                attributesIndex.append(key)
            }
        }
//        println("\nattribute keys: \(attributesIndex)\n")
        
        // Flip the attributesMap dict
        var amap:Dictionary<String, String> = Dictionary()
        for key in attributesMap.keys {
            var val: String? = attributesMap[key]
            amap[val!] = key
        }
//        println("\nattributes map: \(amap)\n")
        
        // Iterate over attributes k/v and set
        for key in attributes.keys {
            println("key: \(key)")
            var propertyName:String?     = amap[key]
            var propertyVal: AnyObject?  = attributes[key]
            
            if (propertyName && propertyVal){
                println(" prop: \(propertyName!) : \(propertyVal!)")
                println("  setting..")
                setValue(propertyVal!, forKey: propertyName!)
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
