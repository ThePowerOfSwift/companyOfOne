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
    
    func createDocument(titleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?, currentOccurrence:Occurrence?){
        
        let context = AppDelegate.viewContext
        let document = Document(context:context)
        
        if let titleTag = titleTag{
             document.titleTag = titleTag
        }
        if let category = currentCategory{
            document.category = category
        }
        if let subCategory = currentSubCategory{
            document.subCategory = subCategory
        }
        if let occurrence = currentOccurrence{
            document.occurrence = occurrence
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
    
    func retrieveAllDocuments(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        documents = try! context.fetch(request) as! [Document]
        //currentCategory = categories[0]
    }
    
    func deleteDocument(document: Document){
        let context = AppDelegate.viewContext
        context.delete(document)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        retrieveAllDocuments()
    }
}
