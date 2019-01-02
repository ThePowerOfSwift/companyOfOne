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
    
    @IBOutlet weak var SettingsTableView: UITableView!
    
    var settings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = ["Account","Categories","Output"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell")! as! SettingsTableViewCell
        let myItem = settings[indexPath.row]
        cell.titleLabel.text = myItem
        return cell
    }
    
    //MARK: - Prepare For Seque To Categories
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoryViewController" {
            if let indexPath = SettingsTableView.indexPathForSelectedRow {
                let controller = segue.destination as! CategoryTableViewController
                controller.selectedSettingName = self.settings[indexPath.row] 
                //controller.selectedSetting = self.categories[indexPath.row]
            }
        }
    }
}
