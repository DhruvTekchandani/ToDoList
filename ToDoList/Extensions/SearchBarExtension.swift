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
        // filtering the items from the to-do list
        // by using the search bar
        // that is based on the title
        // filtering based on the predicate
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    // checks when a user changes a any letter in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if seachBar.text?.count == 0 {
            loadItems()
            // put the keyboard and stop flashing
            // editing has ended
            // do this on the main thread to work
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
