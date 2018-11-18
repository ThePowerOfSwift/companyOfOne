//
//  Category.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import CoreData



class Category: NSManagedObject{
    
    var categories:[Category] = []
    var currentCategory:Category?
    
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
        if self.categories.count != 0{
            currentCategory = categories[0]
        }
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
}
