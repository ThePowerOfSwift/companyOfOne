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
    static var currentFilter:String = "All But Mail And Receipts"
    static var currentScope:Int = 0
    static var fetchHandlerDebugMode:Bool = true
    
    
    
    class func updateSearchText(searchText:String){
        currentFilter = searchText
    }
    class func updateSearchScope(searchScope:Int){
        currentScope = searchScope
    }
    
    //This is the function that populates the .completeDocumentArray per viewController (tab)
    
    class func fetchFilteredDocuments(){
        
        //set up the context of the coreData request for a Document sorted by documentDate
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
        
        
        //break up the requests based on currentScope
        switch currentScope{
            
            //TODO: - TO ADD: Need the results to happen immediatelty instead of waiting for the full word
            
        case 0:  //Category
            if fetchHandlerDebugMode{
                print("\(self) : search scope is Category")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
            if currentFilter == "All But Mail And Receipts" {
                request.predicate = NSPredicate(format: "toCategory.name != %@  AND toCategory.name != %@ ", "Mail", "Receipts")
                
                //Mail and Receipts are fetched using the actual search term against category names
            }else{
                request.predicate = NSPredicate(format: "toCategory.name BEGINSWITH[c] %@", currentFilter)
            }
            ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
            
        case 1: //SubCategory
            if fetchHandlerDebugMode{
                print("\(self) : search scope is SubCategory")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
            request.predicate = NSPredicate(format: "toSubCategory.name BEGINSWITH[c] %@", currentFilter)
            ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
            
        case 2: //Title/Tag
            if fetchHandlerDebugMode{
                print("\(self) : search scope is Title/Tag")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
            request.predicate = NSPredicate(format: "titleTag BEGINSWITH[c] %@", currentFilter)
            ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
        default:
            if fetchHandlerDebugMode{
                print("\(self) : ERROR: search scope is \(FetchHandler.currentScope) ")
                print("\(self) : ERROR: search filter is \(FetchHandler.currentFilter)\n")
            }
        }
        
        
        
        
        
        
        //        //Documents are fetched using a blank filter (everything) and then removing what the Mail and Receipts filters fetch, ugly!
        //        if currentFilter == "All But Mail And Receipts" {
        //            request.predicate = NSPredicate(format: "toCategory.name != %@  AND toCategory.name != %@ ", "Mail", "Receipts")
        //
        //            //Mail and Receipts are fetched using the actual search term against category names
        //        }else{
        //            request.predicate = NSPredicate(format: "toCategory.name == %@", currentFilter)
        //        }
        //whatever is fetched is added to the singleton arrays
        //        ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
        //
        //        //I think this will be for documents created using the occurrence system
        //        ArrayHandler.sharedInstance.incompleteDocumentArray = try! context.fetch(request) as! [Document]
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
        fetchFilteredDocuments()
        if fetchHandlerDebugMode{
            print("\(self) : search scope is \(currentScope)")
            print("\(self) : search filter is \(currentFilter)\n")
        }
    }
}
