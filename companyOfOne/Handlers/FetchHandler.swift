//
//  FetchHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-11.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class FetchHandler: NSObject {
    //TODO: - I think I can use class functions instead of singleton for this, yes works
    override private init() {}
    //Default filter
    static var currentFilter:String = ""
    static var debugMode:Bool = false
    
    
    //This is the function that populates the .completeDocumentArray per viewController (tab) and 
    class func fetchFilteredDocuments(searchTerm:String){
        
        //move the searchTerm to a class variable so it can me used in any class function
        currentFilter = searchTerm
        
        //set up the context of the coreData request for a Document sorted by documentDate
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
        
        if debugMode{
            print("current filter in fetchHandler : \(FetchHandler.currentFilter)")
        }
        
        //Documents are fetched using a blank filter (everything) and then removing what the Mail and Receipts filters fetch, ugly!
        if currentFilter == "" {
            request.predicate = NSPredicate(format: "toCategory.name != %@  AND toCategory.name != %@ ", "Mail", "Receipts")
            
            //Mail and Receipts are fetched using the actual search term against category names
        }else{
            request.predicate = NSPredicate(format: "toCategory.name == %@", currentFilter)
        }
        //whatever is fetched is added to the singleton arrays
        ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
        
        //I think this will be for documents created using the occurrence system
        ArrayHandler.sharedInstance.incompleteDocumentArray = try! context.fetch(request) as! [Document]
    }
    
    class func deleteDocumentAndFetchFilteredDocuments(document: Document){
        let context = AppDelegate.viewContext
        context.delete(document)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array after deletion of a document
        fetchFilteredDocuments(searchTerm: currentFilter)
        if debugMode{
            print("current filter in fetchHandler for refresh after delete of document: \(FetchHandler.currentFilter)")
        }
        
    }
}
