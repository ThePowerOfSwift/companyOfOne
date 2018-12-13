//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate , UITabBarDelegate{
    
    enum edit_View_State {
        case edit
        case view
    }
    
    enum dateFilter_SelectAll_DeSelectAll_State {
        case dateFilter
        case selectAll
        case deSelectAll
    }
    
    enum selectForExport_Normal_State {
        case select
        case normal
    }
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var pressedShareButton: UIBarButtonItem!
    @IBOutlet weak var docTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let document = Document()
    var selectModeIsOn:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewControllerForSelectedTab()
        registerNibs()
        setupTableViewForPopulation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isNavigationBarHidden = true
        setupTableViewForPopulation()
    }
    
    //MARK: - Custom Functions
    
    func updateViewControllerForSelectedTab(){
        if let selectedTabIndex = tabBarController?.selectedIndex {
            switch selectedTabIndex {
            case 1: self.navBar.topItem?.title = "Documents"
            case 2:  self.navBar.topItem?.title = "Snail Mail"
            case 3:  self.navBar.topItem?.title = "Personal Receipts"
            default: break
            }
        }
    }
    
    func setupTableViewForPopulation(){
        ArrayHandler.sharedInstance.outputArray.removeAll()
        document.retrieveAllDocuments(filteredBy: "\(FetchHandler.sharedInstance.currentFilter)")
        docTableView.reloadData()
    }
    
    func registerNibs(){
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        docTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
    }
    
    //MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayHandler.sharedInstance.documentArray.count//?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docViewTableViewCell")! as! DocViewTableViewCell
        cell.isSelectedForExport = ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport
        if cell.isSelectedForExport{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            print("in cellForRow checkmark\(cell.isSelectedForExport )")
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            print("in cellForRow Disclosure\(cell.isSelectedForExport )")
        }
        
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
        if selectModeIsOn == true {
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                cell.accessoryType = .checkmark
                ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport = true
                print("in didSelect disclosure \(ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport )")
            }
        }else{
            performSegue(withIdentifier: "toEditViewControllerFromDocs", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .disclosureIndicator
            ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport = false
            print("in didSelect disclosure \(ArrayHandler.sharedInstance.documentArray[indexPath.row].isSelectedForExport )")
        }
    }
    
    //MARK: - Actions
    
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
    
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        if selectModeIsOn { //this button is Select All
            let totalRows = docTableView.numberOfRows(inSection: 0)
            for item in ArrayHandler.sharedInstance.documentArray {
                item.isSelectedForExport = true
                docTableView.reloadData()
            }
            for row in 0..<totalRows {
                docTableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            }
        }else{
            // this is for the date filter code
        }
    }
    
    //MARK: - Segue
    
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


