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
    
    var subCategories: [SubCategory] = []
    var selectedCategoryName = String()
    var selectedCategory = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createSubCategory(subCategoryName: "Personal")
//        createSubCategory(subCategoryName: "Business")
        self.title = selectedCategoryName
        //this updates the local array
        retrieveAllSubCategories()
    }
    
    // MARK: - TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell", for: indexPath)
        let subCategory = subCategories[indexPath.row]
        cell.textLabel!.text = subCategory.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let subCategoryToDelete = subCategories[indexPath.row]
            deleteSubCategory(subCategory: subCategoryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK:- Create / Retrieve / Delete CoreData
    
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
            self.createSubCategory(subCategoryName: subCategoryName)
            self.retrieveAllSubCategories()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func createSubCategory(subCategoryName: String){
        let context = AppDelegate.viewContext
        let subCategory = SubCategory(context:context)
        subCategory.name = subCategoryName
        subCategory.parent = selectedCategory
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save subCategory. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllSubCategories(){
        let subSet = selectedCategory.child
        subCategories = subSet?.allObjects as! [SubCategory]
    }
    
    func deleteSubCategory(subCategory: SubCategory){
        let context = AppDelegate.viewContext
        context.delete(subCategory)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        retrieveAllSubCategories()
    }
}

