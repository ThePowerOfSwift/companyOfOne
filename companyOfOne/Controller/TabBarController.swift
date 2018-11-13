//
//  TabBarController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-01.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].title = "Home"
       
        tabBar.items?[1].title = "Docs"
       
        tabBar.items?[2].title = "Mail"
       
        tabBar.items?[3].title = "Receipts"
    }
}
