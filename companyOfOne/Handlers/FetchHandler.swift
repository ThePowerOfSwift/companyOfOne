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
    
    
    
     class func fetchSearchText(searchText:String){
        currentFilter = searchText
    }
    class func fetchSearchScope(searchScope:Int){
        currentScope = searchScope
    }
        
    //This is the function that populates the .completeDocumentArray per viewController (tab) and 
   // class func fetchFilteredDocuments(searchTerm:String, searchScope:Int){
        class func fetchFilteredDocuments(){
        
        //move the searchScope and searchTerm to class variables so it can be used in any class function
//        currentScope = searchScope
//        currentFilter = searchTerm
        
        switch currentScope{
        case 0:
            if fetchHandlerDebugMode{
                print("\(self) : search scope is Category")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
        case 1:
            if fetchHandlerDebugMode{
                print("\(self) : search scope is SubCategory")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
            
        case 2:
            if fetchHandlerDebugMode{
                print("\(self) : search scope is Title/Tag")
                print("\(self) : search filter is \(FetchHandler.currentFilter)\n")
            }
        default:
            print("Default for scope")
        }
      
        
        //set up the context of the coreData request for a Document sorted by documentDate
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
        
       
        
        //Documents are fetched using a blank filter (everything) and then removing what the Mail and Receipts filters fetch, ugly!
        if currentFilter == "All But Mail And Receipts" {
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
        fetchFilteredDocuments()
        if fetchHandlerDebugMode{
            print("\(self) : search scope is \(currentScope)")
            print("\(self) : search filter is \(currentFilter)\n")
        }
    }
}
