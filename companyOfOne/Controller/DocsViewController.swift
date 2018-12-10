//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var pressedShareButton: UIBarButtonItem!
    @IBOutlet weak var docTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let document = Document()
    var selectModeIsOn:Bool = false
    
    override func viewDidLoad() {
//        ArrayHandler.sharedInstance.checked = Array(repeating: false, count: ArrayHandler.sharedInstance.documentArray.count)
        ArrayHandler.sharedInstance.outputArray.removeAll()
        if let selectedTabIndex = tabBarController?.selectedIndex {
            switch selectedTabIndex {
            case 1: self.navBar.topItem?.title = "Documents" // Customize ViewController for tab 2 Docs
            case 2:  self.navBar.topItem?.title = "Snail Mail"// Customize ViewController for tab 3 Mail
            case 3:  self.navBar.topItem?.title = "Personal Receipts"// Customize ViewController for tab 4 Receipts
            default: break
            }
            
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "docViewTableViewCell")! as! DocViewTableViewCell
        print("This is the row we are using to retreive from the documentArray : \(indexPath.row)")
        print("\(ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport)")
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
        if selectModeIsOn {
            print("This is the row we are using for selectedDocument : \(indexPath.row)")
            let selectedDocument = ArrayHandler.sharedInstance.documentArray[indexPath.row]
            print("docArray = \(indexPath.row)")
            selectedDocument.isSelectedForExport = true
            if selectedDocument.isSelectedForExport == true {
                  docTableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
            }
            ArrayHandler.sharedInstance.outputArray.append(selectedDocument)
            if ArrayHandler.sharedInstance.outputArray.count > 0 {
            pressedShareButton.image = nil
            pressedShareButton.title = "Export"
            pressedShareButton.tintColor = nil
        }
            
        }else{
            performSegue(withIdentifier: "toEditViewControllerFromDocs", sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        ArrayHandler.sharedInstance.outputArray.remove(at: indexPath.row)
        let deSelectedDocument = ArrayHandler.sharedInstance.documentArray[indexPath.row]
        deSelectedDocument.isSelectedForExport = false
        if deSelectedDocument.isSelectedForExport == false {
            docTableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .disclosureIndicator
        }
        if ArrayHandler.sharedInstance.outputArray.count == 0 {
            pressedShareButton.title = nil
            pressedShareButton.image = #imageLiteral(resourceName: "upload")
           pressedShareButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
        }
    }
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        selectModeIsOn = !selectModeIsOn
        if selectModeIsOn {
            print("select mode is on")
            pressedShareButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
            filterButton.image = nil
            filterButton.title = "Select All"
            docTableView?.allowsMultipleSelection = true
            
        }else{
            print("select mode is off")
            let allCells = docTableView.visibleCells
            for cell in allCells {
                cell.accessoryType = .disclosureIndicator
            }
            pressedShareButton.tintColor = nil
            filterButton.title = nil
            filterButton.image = #imageLiteral(resourceName: "filter")
            docTableView?.allowsMultipleSelection = false
        }
        //        guard let image = UIImage(named: "testDoc") else { return }
        //        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
        //            if completed {
        //                print("completed")
        //            } else {
        //                print("cancelled")
        //            }
        //        }
        //        present(activityController, animated: true) {
        //            print("presented")
        //        }
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


