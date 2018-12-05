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
    //let document = Document(context:AppDelegate.viewContext) <-- this adds a space to the tableView each time the app loads
    let document = Document()
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        docTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
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
     // let cell = Bundle.main.loadNibNamed("DocViewTableViewCell", owner: self, options: nil)?.first as! DocViewTableViewCell
       // docTableView.addSubview(cell)
       // let cell = tableView.dequeueReusableCell(withIdentifier: "displayTableViewCell")! as! DisplayTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "docViewTableViewCell")! as! DocViewTableViewCell
        cell.titleTagLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].titleTag
        cell.categoryLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].toCategory?.name
        cell.subCategoryLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].toSubCategory?.name
        cell.dateLabel.text = ArrayHandler.sharedInstance.documentArray[indexPath.row].documentDate?.format()
        //cell.occurenceLabel.text = document?.occurrence?
        if let imageData = ArrayHandler.sharedInstance.documentArray[indexPath.row].pictureData {
            cell.docImageView.image = UIImage(data: imageData)
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEditViewControllerFromDocs", sender: nil)
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
                nextController.fromDocsViewController = true
                nextController.currentTableViewIndexPathRow = indexPath.row
                if let titleTag = ArrayHandler.sharedInstance.documentArray[indexPath.row].titleTag {
                    nextController.currentTitleTag = titleTag
                }
                if let categoryName = ArrayHandler.sharedInstance.documentArray[indexPath.row].toCategory?.name {
                    nextController.categorySubCategoryLabels.insert(categoryName, at: 0)
                }
                if let subCategoryName = ArrayHandler.sharedInstance.documentArray[indexPath.row].toSubCategory?.name {
                    nextController.categorySubCategoryLabels.insert(subCategoryName, at: 1)
                }
                if let documentDate = ArrayHandler.sharedInstance.documentArray[indexPath.row].documentDate{
                    nextController.currentDate = documentDate
                }
                if let imageData = ArrayHandler.sharedInstance.documentArray[indexPath.row].pictureData {
                    if let image = UIImage(data: imageData) {
                        nextController.currentImage = image
                    }
                }
            }
        }
    }
}


