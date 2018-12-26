//
//  TabBarController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-01.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit



class TabBarController: UITabBarController{
    var updatedTabBarIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].title = "Home"

        tabBar.items?[1].title = "Documents"
       
        tabBar.items?[2].title = "Snail Mail"
        
        tabBar.items?[3].title = "Personal Receipts"
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.tabBar.items?[0].title = "Home"
//        self.tabBar.items?[0].badgeValue = "1"
//
//        tabBar.items?[1].title = "Documents"
//
//        tabBar.items?[2].title = "Snail Mail"
//
//        tabBar.items?[3].title = "Personal Receipts"
//    }
//
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        if let title = item.title{
            switch title {
            case "Home":
                print("Title in tab bar for didSelect tabBar item:\(title)")
//                if let index = tabBarController?.selectedIndex{
//                  self.myDelegate?.updatedTabBarIndex = index
//                }
            case "Documents":
                print("Title in tab bar for didSelect tabBar item:\(title)")
//                if let index = tabBarController?.selectedIndex{
//                   self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "")
            case "Snail Mail":
                print("Title in tab bar for didSelect tabBar item:\(title)")
//                if let index = tabBarController?.selectedIndex{
//                   self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "Mail")
            case "Personal Receipts":
                print("Title in tab bar for didSelect tabBar item:\(title)")
//                if let index = tabBarController?.selectedIndex{
//                self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "Receipts")
            default: break
            }
        }
    }
}
