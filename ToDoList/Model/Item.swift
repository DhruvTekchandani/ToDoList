//
//  Item.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/19/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import Foundation

// Must conform to encodable to either be read as JSON or Plist
// all variables must have its data types

// -> Must Encode & Decode to save and read data

class Item : Codable{
    var title : String = ""
    var done : Bool = false
}
