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
    
    //MARK: - Constants
    let customView = CommonDisplayView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        createTotalView()
        registerTableViewNibs()
        updateNavBarTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
        customView.exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
        confirmAllValues()
    }
    
    
    
    func createTotalView(){
        if let bounds = parent?.view.bounds {
            customView.frame = bounds
        }
        self.view.addSubview(customView)
        customView.exportMode = .off
    }
    
    func registerTableViewNibs(){
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        customView.commonTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
    }
    
    func updateNavBarTitle(){
        customView.commonNavBar.topItem?.title = "Personal Receipts"
    }
    
    func updateTableView(){
        customView.setupTableViewForPopulation()
    }
    
    func confirmAllValues(){
        if customView.debugMode{
            print("ReceiptsViewController viewWillAppear confirming export mode is \(customView.exportMode).\n")
            print("ReceiptsViewController viewWillAppear confirming selected mode is \(customView.selectedMode).\n")
            print("ReceiptsViewController viewWillAppear confirming that \(customView.exportCountObserverForUIUpdates) documents are selected for export\n")
        }
    }
}

