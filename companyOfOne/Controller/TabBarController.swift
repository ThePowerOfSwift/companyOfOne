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
       
        tabBar.items?[1].title = "Documents"
       
        tabBar.items?[2].title = "Snail Mail"
       
        tabBar.items?[3].title = "Personal Receipts"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toCommonViewControllerFromReceipts" {
        let nextController = segue.destination as! DocsViewController
        nextController.title = "Receipts"
        }
        
      if segue.identifier == "toCommonViewControllerFromMail" {
        let nextController = segue.destination as! DocsViewController
        nextController.title = "Mail"
        }
    }
}
