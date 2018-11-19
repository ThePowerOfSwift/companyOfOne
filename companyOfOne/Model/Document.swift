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
 
    //var documents:[Document] = []
    
    
    func createDocument(titleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?, currentOccurrence:Occurrence?){
        
        let context = AppDelegate.viewContext
        let document = Document(context:context)
        
        if let titleTag = titleTag{
             document.titleTag = titleTag
        }
        if let category = currentCategory{
           // category.toDocument? = document
//            category.toDocument = document
            category.addToToDocument(document)
            
        }
        if let subCategory = currentSubCategory{
            subCategory.addToToDocument(document)
        }
//        if let occurrence = currentOccurrence{
//            document.occurrence = occurrence
//        }
        
        do {
            try context.save()
            print("Saved succesfully")
            print("\(document.toSubCategory?.name ?? "No title or tag")")
            print("\(document.toCategory?.name ?? "To be categorized")")
//            print("\(document.subCategory?.name ?? "To be sub categorized")")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllDocuments(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "titleTag", ascending: true)]
        ArrayHandler.sharedInstance.documentArray = try! context.fetch(request) as! [Document]
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
