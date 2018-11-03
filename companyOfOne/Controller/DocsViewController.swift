//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayTableViewCell")! as! DisplayTableViewCell
    
        cell.titleTagLabel.text = "Rent Cheque"
        cell.categoryLabel.text = "Rental"
        cell.subCategoryLabel.text = "Income"
        cell.dateLabel.text = "Dec 21, 2018"
        cell.docImageView.clipsToBounds = true
        cell.docImageView.image = #imageLiteral(resourceName: "testDoc")
        return cell
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
