//
//  SettingsViewContoller.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-10.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var tableViewArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewArray = ["Categories", "SubCategories"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")! as UITableViewCell
        let myItem = tableViewArray[indexPath.row]
        cell.textLabel?.text = myItem
        //cell!.detailTextLabel?.text = myItem.addedByUser
        
        return cell
    }
    
    
}
