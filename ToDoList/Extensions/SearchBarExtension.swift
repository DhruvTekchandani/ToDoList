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
        // creating a fetch request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        // to query we requie NS-predicate
        // takes what the user types in the search bar is [cd] -> insensitive
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", seachBar.text!)
        // sorting data a-z
        // sort descriptiors expects an array
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        // fetching the request from core-data
        loadItems(with: request, predicate: predicate)
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
