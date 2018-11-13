//
//  Occurrence.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-24.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import CoreData

class Occurrence:NSManagedObject{
    
    var occurrences:[String] = ["None",
                               "Biweekly",
                               "Monthly",
                               "Yearly"]
    var currentOccurrence:Occurrence?
}
