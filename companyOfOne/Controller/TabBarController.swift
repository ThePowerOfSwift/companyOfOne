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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let title = item.title{
            switch title {
            case "Documents":
                print("Title in tab bar for didSelect tabBar item:\(title)")
                FetchHandler.currentFilter = ""
            case "Snail Mail":
                print("Title in tab bar for didSelect tabBar item:\(title)")
                FetchHandler.currentFilter = "Mail"
            case "Personal Receipts":
                print("Title in tab bar for didSelect tabBar item:\(title)")
                FetchHandler.currentFilter = "Receipts"
            default: break
            }
        }
    }
}
