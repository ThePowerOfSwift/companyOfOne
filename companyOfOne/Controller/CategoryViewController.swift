//
//  CategoryViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-11.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit


class CategoryViewController: UITableViewController, CategoryDelegate{


    var tableViewArray = [Category]()
    var currentCategory = Category(name: "what the heck")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = HomeViewController()
        delegate.delegate = self
        
        //tableViewArray = ["Category 1", "Category 2", "Category 3"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell")! as! SettingsTableViewCell
        let myItem = tableViewArray[indexPath.row]
        cell.categoryTitleLabel.text = myItem.name
        return cell
    }
    
    //MARK: Category Delegate Methods
    
    func returnMainArray(array: [Category]) {
        tableViewArray = array
    }
}
