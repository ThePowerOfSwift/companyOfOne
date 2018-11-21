//
//  SubCategoryTableViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-11.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class SubCategoryTableViewController: UITableViewController {
    
    var selectedCategoryName = String()
    var selectedCategory = Category()
    var subCategory = SubCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCategoryName
        //this updates the local array
        subCategory.retrieveAllSubCategories(selectedCategory: selectedCategory)
    }
    
    // MARK: - TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayHandler.sharedInstance.subCategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell", for: indexPath)
        let subCategory = ArrayHandler.sharedInstance.subCategoryArray[indexPath.row]
        cell.textLabel!.text = subCategory.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let subCategoryToDelete = ArrayHandler.sharedInstance.subCategoryArray[indexPath.row]
            subCategory.deleteSubCategory(subCategory: subCategoryToDelete, selectedCategory: selectedCategory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK:- Get SubCategory Name and call createSubCategory
    
    @IBAction func getSubCategoryName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New SubCategory",
                                      message: "Add a new sub category",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let subCategoryName = textField.text else {
                    return
            }
            self.subCategory.createSubCategory(subCategoryName: subCategoryName, selectedCategory: self.selectedCategory)
            self.subCategory.retrieveAllSubCategories(selectedCategory: self.selectedCategory)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

