//
//  Document.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Document:NSManagedObject{
    
    var documents:[Document] = []
    
    func createDoc(titleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?){
        let context = AppDelegate.viewContext
        let document = Document(context:context)
        
        if let titleTag = titleTag{
             document.titleTag = titleTag
        }
        if let category = currentCategory{
            document.category = category
        }
        if let  subCategory = currentSubCategory{
            document.subCategory = subCategory
        }
        do {
            try context.save()
            print("Saved succesfully")
            print("\(document.titleTag ?? "No title or tag")")
            print("\(document.category?.name ?? "To be categorized")")
            print("\(document.subCategory?.name ?? "To be sub categorized")")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
