//
//  ArrayHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-17.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ArrayHandler: NSObject{

    static let sharedInstance = ArrayHandler()
    override private init() {}
    var incompleteDocumentArray:[Document] = []
    var completeDocumentArray:[Document] = [] 
    var categoryArray:[Category] = []
    var subCategoryArray:[SubCategory] = []
    var exportArray:[Document] = []
    }
