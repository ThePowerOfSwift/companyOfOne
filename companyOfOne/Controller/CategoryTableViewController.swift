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
    
    var categories: [Category] = []
    var selectedSettingName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCategory(categoryName: "Mail")
        self.title = selectedSettingName
        //this updates the local array
        retrieveAllCategories()
    }
    
    // MARK: - TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel!.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let categoryToDelete = categories[indexPath.row]
            deleteCategory(category: categoryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK:- Create / Retrieve / Delete CoreData
    
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
            self.createCategory(categoryName: categoryName)
            self.retrieveAllCategories()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func createCategory(categoryName: String){
        let context = AppDelegate.viewContext
        let category = Category(context:context)
        category.name = categoryName
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllCategories(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        categories = try! context.fetch(request) as! [Category]
    }
    
    func deleteCategory(category: Category){
        let context = AppDelegate.viewContext
        context.delete(category)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        retrieveAllCategories()
    }
    
    //MARK: - Prepare For Seque To SubCategories
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategories" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! SubCategoryTableViewController
                controller.selectedCategoryName = self.categories[indexPath.row].name ?? "Default"
                controller.selectedCategory = self.categories[indexPath.row]
            }
        }
    }
}

