//
//  ReceiptsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ReceiptsViewController: UIViewController {
   
    let customView = CommonDisplayView()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        createTotalView()
        registerTableViewNibs()
        updateNavBarTitle()
        
        // Do any additional setup after loading the view.
    }
    
    func createTotalView(){
        if let bounds = parent?.view.bounds {
             customView.frame = bounds
        }
        self.view.addSubview(customView)
    }
    
    func registerTableViewNibs(){
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        customView.commonTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
    }
    
    func updateNavBarTitle(){
        if let selectedTabIndex = tabBarController?.selectedIndex {
            //     TODO: - TO FIX: This index is not working correctly
            print("selected tab index: \(selectedTabIndex)")
            
            switch selectedTabIndex  {
            case 1: customView.commonNavBar.topItem?.title = "Documents"
            case 2: customView.commonNavBar.topItem?.title = "Snail Mail"
            case 3: customView.commonNavBar.topItem?.title = "Personal Receipts"
            default: break
                //            }
            }            //            docTableView.reloadData()
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
