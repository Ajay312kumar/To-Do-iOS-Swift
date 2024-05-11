//
//  ViewController.swift
//  TodeyApp
//
//  Created by Ajay Kumar on 11/05/24.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
        //            itemArray = item
        //        }
        
        let newItem1 = Item()
        newItem1.title = "Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Demorgan"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "john"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Mikey doe"
        itemArray.append(newItem4)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        if item.done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let newItemTitle = textField.text, !newItemTitle.isEmpty {
                let newItem = Item()
                newItem.title = newItemTitle
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
