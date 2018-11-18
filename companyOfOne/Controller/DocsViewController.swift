//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var docTableView: UITableView!
    
    let document = Document(context:AppDelegate.viewContext)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        document.retrieveAllDocuments()
        docTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isNavigationBarHidden = true
        document.retrieveAllDocuments()
        docTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ArrayHandler.sharedInstance.documentArray.count//?? 2
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayTableViewCell")! as! DisplayTableViewCell
        cell.titleTagLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].titleTag
        cell.categoryLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].toCategory?.name
        //cell.subCategoryLabel.text = document.documents[indexPath.row].subCategory?.name
        cell.dateLabel.text = "Dec 21, 2018"
        //cell.occurenceLabel.text = document?.occurrence?
        cell.docImageView.image = #imageLiteral(resourceName: "testDoc")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let documentToDelete = ArrayHandler.sharedInstance.documentArray[indexPath.row]
            document.deleteDocument(document: documentToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
            if let indexPath = self.docTableView.indexPathForSelectedRow {
                let nextController = segue.destination as! EditViewController
                let titleTag = ArrayHandler.sharedInstance.documentArray[indexPath.row].titleTag
                nextController.titleTagLabel?.text = titleTag
            }
            
        }
    }
}

