//
//  SubCategory.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import CoreData

class SubCategory:NSManagedObject{
    
     var subCategories:[SubCategory] = []

    func createSubCategory(subCategoryName: String, selectedCategory:Category){
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
    
    func retrieveAllSubCategories(selectedCategory:Category){
        let subSet = selectedCategory.child
        subCategories = subSet?.allObjects as! [SubCategory]
    }
    
    func deleteSubCategory(subCategory: SubCategory, selectedCategory:Category){
        let context = AppDelegate.viewContext
        context.delete(subCategory)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        retrieveAllSubCategories(selectedCategory: selectedCategory)
    }
}
