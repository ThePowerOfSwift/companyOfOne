//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var document:Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        document?.retrieveAllDocuments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let document = self.document{
             return document.documents.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayTableViewCell")! as! DisplayTableViewCell
        cell.titleTagLabel.text = document?.documents[indexPath.row].titleTag
        cell.categoryLabel.text = document?.documents[indexPath.row].category?.name
        cell.subCategoryLabel.text = document?.documents[indexPath.row].subCategory?.name
        cell.dateLabel.text = "Dec 21, 2018"
        //cell.occurenceLabel.text = document?.occurrence?
        cell.docImageView.image = #imageLiteral(resourceName: "testDoc")
        return cell
    }
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        guard let image = UIImage(named: "testDoc") else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancelled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditViewControllerFromDocs" {
            let nextController = segue.destination as! EditViewController
        }
    }
}
