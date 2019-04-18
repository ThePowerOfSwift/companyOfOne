//
//  ShareProtocol.swift
//  companyOfOne
//
//  Created by Jamie on 2019-04-18.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation

protocol MyShareDelegate: class {
    func populateCategoryTableviewInShareExtension()->[Category]
}
