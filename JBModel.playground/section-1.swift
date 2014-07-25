// Playground - noun: a place where people can play

import UIKit

@objc(User) class User {
    
}

var u = User()
NSClassFromString("User")

let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
path
//let dict = NSDictionary(contentsOfFile: path)

println(NSBundle.allBundles())