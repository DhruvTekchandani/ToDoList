//
//  Item.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/21/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    // creating a relation between item and category using linking objects (realm)
    // reverse relation
    // each item has one relation 
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
