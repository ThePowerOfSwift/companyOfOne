//
//  ReceiptsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ReceiptsViewController: UIViewController {
    
    //This is the template for the new way of doing multiple view controllers sharing a view.
   
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
            customView.commonNavBar.topItem?.title = "Personal Receipts"
        }
    }

