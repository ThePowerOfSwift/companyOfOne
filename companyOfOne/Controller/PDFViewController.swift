//
//  PDFViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2019-01-03.
//  Copyright © 2019 Jamie. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    
    var documentsToDisplay:[Document] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        print(documentsToDisplay.count)

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
