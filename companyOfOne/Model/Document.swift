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

    class func createDocument(currentDocImage:UIImage?, currentTitleTag:String?, currentCategory:Category?, currentSubCategory:SubCategory?, currentOccurrence:Occurrence?, currentOccurrenceDate:Date?, currentDocumentDate:Date?, isSelectedForExport:Bool?){
        
    let generator = UINotificationFeedbackGenerator()
        
    let context = AppDelegate.viewContext
    let document = Document(context:context)
    
    if let titleTag = currentTitleTag{
        document.titleTag = titleTag
    }
    if let category = currentCategory{
        category.addToToDocument(document)
    }
    if let subCategory = currentSubCategory{
        subCategory.addToToDocument(document)
    }
    if let occurrence = currentOccurrence{
        occurrence.addToToDocument(document)
    }
   //pretty sure the above adds the date with it
    if let documentDate = currentDocumentDate{
        document.documentDate = documentDate
    }
    
    if let docImage = currentDocImage {
        let imageData = docImage.jpegData(compressionQuality: 1)
        document.pictureData = imageData
    }
    if let isSelectedForExport = isSelectedForExport{
        document.isSelectedForExport = isSelectedForExport
    }
        do {
            try context.save()
            print("Saved succesfully")
            print("\(document.titleTag ?? "title Tag")")
            print("\(document.toCategory?.name ?? "No category")")
            print("\(document.toSubCategory?.name ?? "No subCategory")")
            print("\(document.toOccurrence?.title ?? "No occurrenct title")")
            print("\(document.toOccurrence?.occurrenceDate?.format() ?? "No occurrence date")")
            print("\(document.documentDate?.format() ?? "No document date")")
//
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        generator.notificationOccurred(.success)
    }
    
    
//    func retrieveAllDocuments(searchTerm: String){
//        //FetchHandler.currentFilter = filteredBy
//        FetchHandler.fetchFilteredDocuments(searchTerm: searchTerm)
//        //print("current filter in retrieveAllDocuments: \(FetchHandler.currentFilter)")
//
//    }
    
//    func deleteDocument(document: Document){  
//        FetchHandler.deleteDocumentAndFetchFilteredDocuments(document: document)
//    }
}
