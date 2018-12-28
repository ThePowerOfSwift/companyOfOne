//
//  TestViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
   

    
    let customView = CommonDisplayView()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        createView()
        registerNibs()
        // Do any additional setup after loading the view.
    }
    
    func createView(){
        if let bounds = parent?.view.bounds {
             customView.frame = bounds
        }
        self.view.addSubview(customView)
    }
    
    func registerNibs(){
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        customView.commonTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
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
