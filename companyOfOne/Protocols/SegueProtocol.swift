//
//  SegueProtocol.swift
//  companyOfOne
//
//  Created by Jamie on 2019-04-14.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation

protocol MySegueDelegate: class {
    func segueToEditViewControllerCalled()
    func segueToPDFViewControllerCalled()
}
