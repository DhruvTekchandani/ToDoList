//
//  Category.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/21/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import Foundation
import RealmSwift

// Category is a realm object
class Category: Object{
    @objc dynamic var name: String = ""
    // creating a one-to-many relation using List (realm) with items
    let items = List<Item>()
}
