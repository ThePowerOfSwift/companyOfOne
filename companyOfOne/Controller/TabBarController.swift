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
    var maiViewController:MailViewController?
    var receiptsViewController:ReceiptsViewController?
    var debugMode:Bool = false
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Documents"
        tabBar.items?[2].title = "Personal Mail"
        tabBar.items?[3].title = "Personal Receipts"
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: - This is what populates the tableView in each tab
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        if let title = item.title{
            switch title {
            case "Home":
                if debugMode{
                   print("Title in tab bar for didSelect tabBar item:\(title)")
                }
            case "Documents":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
                FetchHandler.fetchSearchText(searchText: "")
                FetchHandler.fetchFilteredDocuments()
            case "Personal Mail":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
                FetchHandler.fetchSearchText(searchText: "Mail")
                FetchHandler.fetchFilteredDocuments()
            case "Personal Receipts":
                if debugMode{
                    print("Title in tab bar for didSelect tabBar item:\(title)")
                }
                FetchHandler.fetchSearchText(searchText: "Receipts")
                FetchHandler.fetchFilteredDocuments()
            default: break
            }
        }
    }
}
