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
    //TODO: - I think I can use class functions instead of singleton for this
    override private init() {}
    static var currentFilter:String = ""
    
    class func fetchFilteredDocuments(searchTerm:String){ //class func?
        currentFilter = searchTerm
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
    
        print("current filter in fetchHandler : \(FetchHandler.currentFilter)")
        if currentFilter == "" {
            request.predicate = NSPredicate(format: "toCategory.name != %@  AND toCategory.name != %@ ", "Mail", "Receipts")
        }else{
            request.predicate = NSPredicate(format: "toCategory.name == %@", currentFilter)
        }
        ArrayHandler.sharedInstance.completeDocumentArray = try! context.fetch(request) as! [Document]
    }
    
    class func deleteDocumentAndFetchFilteredDocuments(document: Document){  //class func?
        let context = AppDelegate.viewContext
        context.delete(document)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        fetchFilteredDocuments(searchTerm: currentFilter)
    }
}
