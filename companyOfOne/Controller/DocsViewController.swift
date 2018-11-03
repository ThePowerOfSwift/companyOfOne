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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isNavigationBarHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayTableViewCell")! as! DisplayTableViewCell
    
        cell.titleTagLabel.text = "Rent Cheque"
        cell.categoryLabel.text = "Rental"
        cell.subCategoryLabel.text = "Income"
        cell.dateLabel.text = "Dec 21, 2018"
        cell.occurenceLabel.text = "Monthly"
       
        //cell.docImageView.clipsToBounds = true
        cell.docImageView.image = #imageLiteral(resourceName: "testDoc")
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditViewControllerFromDocs" {
            let nextController = segue.destination as! EditViewController
            
        }
    }

}
