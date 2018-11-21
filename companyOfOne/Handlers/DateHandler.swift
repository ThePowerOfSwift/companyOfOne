//
//  DateHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-21.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation

extension Date {
    func format(format:String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
       return dateString
    }
}
