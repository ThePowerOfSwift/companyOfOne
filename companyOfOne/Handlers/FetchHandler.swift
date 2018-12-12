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
    static let sharedInstance = FetchHandler()
    var currentFilter:String = ""
    
    
    func fetchFilteredDocuments(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Document")
        request.sortDescriptors = [NSSortDescriptor(key: "documentDate", ascending: true)]
        if currentFilter == "" {
            request.predicate = NSPredicate(format: "toCategory.name != %@  AND toCategory.name != %@ ", "Mail", "Receipts")
        }else{
            request.predicate = NSPredicate(format: "toCategory.name == %@", currentFilter)
        }
        ArrayHandler.sharedInstance.documentArray = try! context.fetch(request) as! [Document]
    }
    
    func deleteDocumentAndFetchFilteredDocuments(document: Document){ 
        let context = AppDelegate.viewContext
        context.delete(document)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        fetchFilteredDocuments()
    }
}
