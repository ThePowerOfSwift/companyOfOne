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

    func createDocument(currentDocImage:UIImage?, titleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?, currentOccurrence:Occurrence?, currentDate:Date?, isSelectedForExport:Bool?){
        
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
        
        if let docImage = currentDocImage {
            let imageData = docImage.jpegData(compressionQuality: 1)
            document.pictureData = imageData
        }
        if let isSelectedForExport = isSelectedForExport{
            document.isSelectedForExport = isSelectedForExport
        }
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
        let searchTerm = "Mail"
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
        request.predicate = NSPredicate(format: "toCategory.name == %@", searchTerm)
        ArrayHandler.sharedInstance.documentArray = try! context.fetch(request) as! [Document]
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
