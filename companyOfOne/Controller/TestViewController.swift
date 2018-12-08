//
//  TestViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-08.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
UINib(nibName: "CommonDisplayView", bundle: nil).instantiate(withOwner: self, options: nil)
        // Do any additional setup after loading the view.
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
