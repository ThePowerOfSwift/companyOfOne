//
//  SubCategoryViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-11.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit


class SubCategoryViewController: UITableViewController{
    
    var tableViewArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewArray = ["SubCategory 1", "SubCategory 2", "SubCategory 3"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell")! as! SettingsTableViewCell
        let myItem = tableViewArray[indexPath.row]
        cell.titleLabel.text = myItem
        return cell
    }
    
    
}
