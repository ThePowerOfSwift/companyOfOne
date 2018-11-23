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

    func createDocument(currentDocImage:DocImage?, titleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?, currentOccurrence:Occurrence?, currentDate:Date?){
        
        let context = AppDelegate.viewContext
        let document = Document(context:context)
        
        if let titleTag = titleTag{
             document.titleTag = titleTag
        }
        if let category = currentCategory{
            category.addToToDocument(document)
        }
        if let subCategory = currentSubCategory{
            subCategory.addToToDocument(document)
        }
        if let documentDate = currentDate{
            document.documentDate = documentDate
        }
//        if let docImage = currentDocImage {
//            let docUIImage = docImage as! UIImage
//           docImage.imageData = UIImageJPEGRepresentation(docImage as! UIImage, 1) else {
//                // handle failed conversion
//                print("jpg error")
//                return
//            }
//
//            document.toDocImage?.imageData = docImage
//        }
//        if let occurrence = currentOccurrence{
//            document.occurrence = occurrence
//        }
        
        do {
            try context.save()
            print("Saved succesfully")
            print("\(document.titleTag ?? "No date")")
            print("\(document.toCategory?.name ?? "No category")")
            print("\(document.toSubCategory?.name ?? "No subCategory")")
            print("\(document.documentDate?.format() ?? "No date")")
//
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
