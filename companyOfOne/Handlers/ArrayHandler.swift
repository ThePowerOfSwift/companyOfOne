//
//  ArrayHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-17.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ArrayHandler: NSObject {
    static let sharedInstance = ArrayHandler()
    var documentArray:[Document] = []
    var categoryArray:[Category] = []
    var subCategoryArray:[SubCategory] = []
}
