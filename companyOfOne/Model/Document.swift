//
//  Document.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation

class Document{
    var titleTag:String
    var category:Category
    var subCategory:SubCategory
    var occurrence:String
    var occurrenceDate:Date
    var docDate:Date
    
    init(titleTag: String, category: Category, subCategory: SubCategory, occurrence: String, occurrenceDate:Date, docDate:Date) {
        self.titleTag = titleTag
        self.category = category
        self.subCategory = subCategory
        self.occurrence = occurrence
        self.occurrenceDate = occurrenceDate
        self.docDate = docDate
    }
}
