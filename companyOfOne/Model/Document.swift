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
   // @NSManaged var titleTag:String?
    //@NSManaged var category:Category?
    //@NSManaged var subCategory:SubCategory
    @NSManaged var occurrence:String
    @NSManaged var occurrenceDate:Date
    @NSManaged var docDate:Date
    @NSManaged var docImage:UIImage
//
//    init(titleTag: String, category: Category, subCategory: SubCategory, occurrence: String, occurrenceDate:Date, docDate:Date) {
//        self.titleTag = titleTag
//        self.category = category
//        self.subCategory = subCategory
//        self.occurrence = occurrence
//        self.occurrenceDate = occurrenceDate
//        self.docDate = docDate
//    }
}
