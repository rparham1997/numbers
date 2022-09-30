//
//  Constants.swift
//  Numbers2
//
//  
//
//

import Foundation

// bad practice to have global constants.
// var a = ""

enum StoryboardId: String {
    case main = "Main"
    
    var id: String {
        // Returns the string value of the case.
        return self.rawValue
    }
}

enum ViewControllerId: String {
    case randomTableVC = "RandomTableVC"
    
    var id: String {
        return self.rawValue
    }
}
