//
//  ViewController.swift
//  ToDoList
//
//  Created by It's Now or Never. on 8/19/18.
//  Copyright © 2018 Dhruv Rajesh. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    @IBOutlet weak var seachBar: UISearchBar!
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // this is for user defaults
    // to store small bits of information
    let defaults = UserDefaults.standard
    // Creating our very own plist to store user information
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // Creating search bar delegate
        seachBar.delegate = self
     }
    
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // creating a variable here rather than repeating it everytime
        let item = itemArray[indexPath.row]
    
        cell.textLabel?.text = item.title
        
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // checking if a checkmark exists or not
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // testing to remove an object from the database
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        // saving changes to coredata
        saveItems()
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
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: model manupulation methods
    func saveItems(){
        // saving items into core data
        do{
            try context.save()
        }catch{
            print("app was not able to save the item: \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: loading data from core data
    // reading always requires a fetch request
    func loadItems(){
        // creating a fetch request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("error fetching data from context \(error)")
        }
    }
    
    //MARK: search bar delegate methods
    // Check extension folder
    // SearchBarExtension
    
}




