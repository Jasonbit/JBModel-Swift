//
//  JsonUtils.swift
//  JBModel-Swift
//
//  Created by Jason Lee on 7/24/14.
//  Copyright (c) 2014 Jason Lee. All rights reserved.
//

import UIKit

class JsonUtils: NSObject {

    class func returnJsonAsCollection() -> AnyObject? {

        let bundles = NSBundle.allBundles()
        
        // JBModel-SwiftTests.xctest
        // Still not sure about this part. I took the allBundles() approach because getting a bundle
        // for class was not working correctly.. In obj-c I could do:
        //   NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        //   NSURL *url = [bundle URLForResource:"user" withExtension:@"json"];

        let matches = bundles.filter({$0.bundlePath!.hasSuffix("JBModel-SwiftTests.xctest")})
        let bundle:NSBundle = matches[matches.startIndex] as NSBundle
        let path = bundle.pathForResource("user", ofType: "json")

        var error = NSError?()
        let jsonData = NSData.dataWithContentsOfFile(path!, options: .DataReadingMappedIfSafe, error: &error)
        let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &error)

        // We should only get this if there is some problem with the json not being valid
        if error != nil {
            println("error: \(error!)")
        }
        
        return jsonResult
        
    }

}
