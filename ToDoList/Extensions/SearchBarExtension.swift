//
//  SearchBarExtension.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/21/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// Extension
// Todo list 
extension TodoListViewController : UISearchBarDelegate {
 
    // when a search bar icon is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        
    }
    
}
