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
    
    func retrieveAllDocuments(filteredBy: String){
        FetchHandler.fetchFilteredDocuments()
        print("current filter in retrieveAllDocuments: \(FetchHandler.currentFilter)")
        FetchHandler.currentFilter = filteredBy
    }
    
    func deleteDocument(document: Document){  
        FetchHandler.deleteDocumentAndFetchFilteredDocuments(document: document)
    }
}
