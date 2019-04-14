//
//  TabBarController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-01.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit



class TabBarController: UITabBarController{
    var updatedTabBarIndex:Int?
    var homeViewController:HomeViewController?
    var docViewController:DocsViewController?
    var maiViewController:DocsViewController?
    var receiptsViewController:ReceiptsViewController?
   // var receiptsViewController:DocsViewController?
    var debugMode:Bool = false
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FetchHandler.fetchFilteredDocuments(searchTerm: "Receipts")
//        if let home = homeViewController{
//            home.tabBarItem.badgeValue = "4"
//        }
//        homeTabBar.items!.first!.badgeValue = "4"//("\(ArrayHandler.sharedInstance.incompleteDocumentArray.count)")
        tabBar.items?[0].title = "Home"

        tabBar.items?[1].title = "Documents"

        tabBar.items?[2].title = "Personal Mail"

        tabBar.items?[3].title = "Personal Receipts"

        //self.viewControllers![0].children[0].title = "Home1"

//        self.viewControllers![2].children[0].title = "Mail1"
//        self.viewControllers![3].children[0].title = "Receipts1"
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        tabBar.items?[0].title = "Home"
//        if let home = homeViewController{
//            home.tabBarItem.badgeValue = "4"
//        }
////         homeTabBar.items!.first!.badgeValue = "4"//("\(ArrayHandler.sharedInstance.incompleteDocumentArray.count)")
//
//        tabBar.items?[1].title = "Documents"
//
//        tabBar.items?[2].title = "Snail Mail"
//
//        tabBar.items?[3].title = "Personal Receipts"
//       // self.viewControllers![1].children[0].navigationController?.title = "Doc1"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tabBar.items?[0].title = "Home"
//        if let home = homeViewController{
//            home.tabBarItem.badgeValue = "4"
//        }
////         homeTabBar.items!.first!.badgeValue = "4"//("\(ArrayHandler.sharedInstance.incompleteDocumentArray.count)")
//
//        tabBar.items?[1].title = "Documents"
//
//        tabBar.items?[2].title = "Snail Mail"
//
//        tabBar.items?[3].title = "Personal Receipts"
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        if let title = item.title{
            switch title {
            case "Home":
                if debugMode{
                   print("Title in tab bar for didSelect tabBar item:\(title)")
                }
                
//                if let index = tabBarController?.selectedIndex{
//                  self.myDelegate?.updatedTabBarIndex = index
//                }
            case "Documents":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
//                if let index = tabBarController?.selectedIndex{
//                   self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "")
            case "Snail Mail":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
//                if let index = tabBarController?.selectedIndex{
//                   self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "Mail")
            case "Personal Receipts":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
//                if let index = tabBarController?.selectedIndex{
//                self.myDelegate?.updatedTabBarIndex = index
//                }
                FetchHandler.fetchFilteredDocuments(searchTerm: "Receipts")
            default: break
            }
        }
    }
}
