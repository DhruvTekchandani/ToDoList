//
//  ViewController.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/19/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    @IBOutlet weak var seachBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet{
            // taking in default parameter
            // check function
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Creating search bar delegate
        seachBar.delegate = self
     }
    
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // creating a variable here rather than repeating it everytime
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            // value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // checking to see if the to-do items is not nill
        // if not then write into realm the opp state of the current state
        if let item = todoItems?[indexPath.row] {
            do{
                // write updated propery of item
                try realm.write {
                   item.done = !item.done
                 
                }
            }catch{
                print("error saving done status \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item To The List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // once the user clicks the add item button on the UI-Alert
            // adding the text and the done property to the app
            // must add both because of non-optional types
            if let currentCategory = self.selectedCategory {
                // Writing to realm
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("error while writing item to realm \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: model manupulation methods

    
    //MARK: loading data from core data
    // reading always requires a fetch request method
    // creating a default value when no arguments are provided when function called
    // turning NS-Predicate to an optional so we can call it from else where
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    //MARK: search bar delegate methods
    // Check extension folder
    // SearchBarExtension
    
}




