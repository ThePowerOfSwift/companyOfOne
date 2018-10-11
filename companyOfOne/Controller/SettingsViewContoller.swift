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
        tableViewArray = ["Company Info", "Categories", "Reminders"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell")! as! SettingsTableViewCell
        let myItem = tableViewArray[indexPath.row]
        cell.titleLabel.text = myItem
        return cell
    }

}
