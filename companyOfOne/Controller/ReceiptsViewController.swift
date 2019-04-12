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
        let nib = UINib(nibName: "CommonTableViewCell", bundle: nil)
        customView.commonTableView.register(nib, forCellReuseIdentifier: "commonTableViewCell")
    }
    
    func updateNavBarTitle(){
        customView.commonNavBar.topItem?.title = "Personal Receipts"
    }
    
    func updateTableView(){
        customView.setupTableViewForPopulation()
    }
    
    func confirmAllValues(){
        if customView.debugMode{
            print("\(self) viewWillAppear confirming export mode is \(customView.exportMode).\n")
            print("\(self) viewWillAppear confirming selected mode is \(customView.selectedMode).\n")
            print("\(self) viewWillAppear confirming that \(customView.exportCountObserverForUIUpdates) documents are selected for export\n")
        }
    }
}

