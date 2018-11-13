//
//  CategoryTableViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-11.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var category = Category()
    //var categories: [Category] = []
    var selectedSettingName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSettingName
        //this updates the local array
        category.retrieveAllCategories()
    }
    
    // MARK: - TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath)
        let category = self.category.categories[indexPath.row]
        cell.textLabel!.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let categoryToDelete = category.categories[indexPath.row]
            category.deleteCategory(category: categoryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK:- Get Category Name and call createCategory
    
    @IBAction func getCategoryName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Category",
                                      message: "Add a new category",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let categoryName = textField.text else {
                    return
            }
            self.category.createCategory(categoryName: categoryName)
            self.category.retrieveAllCategories()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //MARK: - Prepare For Seque To SubCategories
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategories" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! SubCategoryTableViewController
                controller.selectedCategoryName = self.category.categories[indexPath.row].name ?? "Default"
                controller.selectedCategory = self.category.categories[indexPath.row]
            }
        }
    }
}

