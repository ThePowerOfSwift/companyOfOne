//
//  DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-03.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocsViewController: UIViewController, UITabBarControllerDelegate , UITabBarDelegate  {
    
    //MARK: - Enums
    enum ExportMode {
        case on
        case off
    }
    
    enum SelectedMode {
        case noneSelected
        case someSelected
        case allSelected
    }
    
    //MARK: - Instance Variables
    
    var exportMode:ExportMode = .off
    var selectedMode:SelectedMode = .noneSelected
    var selectedTabIndex:Int = 0
    var debugMode:Bool = false
    
    //MARK: - Property Observers
    var exportCountObserverForUIUpdates: Int = 0 {
        didSet {
            switch exportCountObserverForUIUpdates {
            case 0 :
                if exportMode == .on{
                    if debugMode{
                         print("0 selected for export")
                    }
                }
                filterButton.title = "Select All"
                selectedMode = .noneSelected
                if exportMode == .off {
                    pressedShareButton.image = #imageLiteral(resourceName: "upload")
                    pressedShareButton.tintColor = nil
                    filterButton.image = #imageLiteral(resourceName: "filter")
                    filterButton.tintColor = nil
                }else{
                    pressedShareButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
                }
            // TODO: - TO FIX: What happens when there is only one items --> Thread 1: Fatal error: Can't form Range with upperBound < lowerBound
            case 1...(ArrayHandler.sharedInstance.completeDocumentArray.count-1):
                if exportMode == .on{
                    if debugMode{
                        print("some selected for export")
                    }
                }
                filterButton.title = "Select All"
                pressedShareButton.tintColor = nil
                selectedMode = .someSelected
            case ArrayHandler.sharedInstance.completeDocumentArray.count:
                if exportMode == .on{
                    if debugMode{
                        print("all selected for export")
                    }
                }
                pressedShareButton.tintColor = nil
                filterButton.title = "Deselect All"
                selectedMode = .allSelected
            default: return
            }
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var documentSearchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var pressedShareButton: UIBarButtonItem!
    @IBOutlet weak var docTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let document = Document()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if debugMode{
            print("from DocsViewController viewDidLoad:")
        }
        //self.tabBarController?.tabBar.isHidden = false
        registerNibs()
        updateViewControllerForSelectedTab()
        setupTableViewForPopulation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if debugMode{
            print("from DocsViewController viewWillAppear:")
        }
        navigationController!.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        updateViewControllerForSelectedTab()
        setupTableViewForPopulation()
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    //MARK: - Custom Functions For Loading View
    
    func updateViewControllerForSelectedTab(){
        self.navBar.topItem?.title = "Documents"
//        let application = UIApplication.shared.delegate as! AppDelegate
//        let tabbarController = application.window?.rootViewController as! UITabBarController
//        selectedTabIndex = tabbarController.selectedIndex
//        if let selectedTabIndex = tabBarController?.selectedIndex {
//            //     TODO: - TO FIX: This index is not working correctly --> this should be solved when I have a viewController for each tab
//            if debugMode{
//                print("selected tab index: \(selectedTabIndex)")
//            }
//            switch selectedTabIndex  {
//            case 1: self.navBar.topItem?.title = "Documents"
//            case 2:  self.navBar.topItem?.title = "Snail Mail"
//            case 3:  self.navBar.topItem?.title = "Personal Receipts"
//            default: break
//                //            }
//            }            //            docTableView.reloadData()
//        }
    }
    
    func setupTableViewForPopulation(){
        //clear the export Array and deselect all items/cells
        deSelectAllForExport()
        ArrayHandler.sharedInstance.exportArray.removeAll()
        exportMode = .off
        selectedMode = .noneSelected
        // docTableView.reloadData()
    }
    
    func registerNibs(){
        let nib = UINib(nibName: "DocViewTableViewCell", bundle: nil)
        docTableView.register(nib, forCellReuseIdentifier: "docViewTableViewCell")
    }
    
    //MARK: - Search Bar Custom Functions
    
    func resetSearch(){
        documentSearchBar.endEditing(true)
        documentSearchBar.showsCancelButton = false
        documentSearchBar.showsScopeBar = false
        resignFirstResponder()
        if debugMode{
            print("about to run the updateViewControllerForSelectedTab")
        }
        updateViewControllerForSelectedTab()
        if debugMode{
            print("completed running the updateViewControllerForSelectedTab")
        }
    }
    
    func completeSearch(){
        //document.retrieveAllDocuments(filteredBy: "\(FetchHandler.currentFilter)")
        documentSearchBar.endEditing(true)
        docTableView.reloadData()
    }
    
    
    //MARK: - Actions
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        switch exportMode {
        case .off:
            exportMode = .on
            pressedShareButton.image = nil
            pressedShareButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
            pressedShareButton.title = "Export"
            filterButton.image = nil
            docTableView?.allowsMultipleSelection = true
        case .on:
            switch selectedMode {
            case .noneSelected:
                if debugMode{
                    print("export mode on, none selected :  run the alert function ")
                }
            case .someSelected:
                if debugMode{
                   print("export mode on, \(ArrayHandler.sharedInstance.exportArray.count) items selected :  run the export function ")
                }
                performSegue(withIdentifier: "toPDFViewControllerFromDocsExportButton", sender: self)
            case .allSelected:
                if debugMode{
                    print("export mode on, \(ArrayHandler.sharedInstance.exportArray.count) items selected:  run the export function ")
                }
                performSegue(withIdentifier: "toPDFViewControllerFromDocsExportButton", sender: self)
            }
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        switch exportMode {
        case .on:
            switch selectedMode {
            case .noneSelected:
                selectAllForExport()
            case .someSelected:
                selectAllForExport()
            case.allSelected:
                deSelectAllForExport()
            }
        case .off:
            if debugMode{
                  print("run the date filter function here")
            }
        }
    }
    
    //MARK: - Export Functions
    
    func selectAllForExport(){
        //this sets the model objects isSelectedForExport bool and adds to the exportArray
        let totalRows = docTableView.numberOfRows(inSection: 0)
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            if item.isSelectedForExport == false {
                item.isSelectedForExport = true
                ArrayHandler.sharedInstance.exportArray.append(item)
            }
        }
        docTableView.reloadData()
        //this selects all of the cells in the current display
        for row in 0..<totalRows {
            docTableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
        //this propery observer updates state and UI
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    func deSelectAllForExport(){
        //this clears the model objects isSelectedForExport bool and removes the exportArray
        let totalRows = docTableView.numberOfRows(inSection: 0)
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            item.isSelectedForExport = false
        }
        
        //model updates should happen in the model but ... how?
        ArrayHandler.sharedInstance.exportArray.removeAll()
        docTableView.reloadData()
        
        //this deselects all of the cells in the current display
        for row in 0..<totalRows {
            docTableView.deselectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated:false)
        }
        ///this propery observer updates state and UI
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    //MARK: - Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditViewControllerFromDocs" {
            if let indexPath = self.docTableView.indexPathForSelectedRow {
                let nextController = segue.destination as! EditViewController
                nextController.fromDocsViewController = true
                nextController.currentTableViewIndexPathRow = indexPath.row
                if let titleTag = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].titleTag {
                    nextController.currentTitleTag = titleTag
                }
                if let categoryName = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].toCategory?.name {
                    nextController.categorySubCategoryLabels[0] = categoryName
                }
                if let subCategoryName = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].toSubCategory?.name {
                    nextController.categorySubCategoryLabels[1] = subCategoryName
                }
                if let documentDate = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].documentDate{
                    nextController.currentDate = documentDate
                }
                if let imageData = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].pictureData {
                    if let image = UIImage(data: imageData) {
                        nextController.currentImage = image
                    }
                }
                if let occurrence = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].toOccurrence{
                    if let title = occurrence.title {
                        nextController.occurrenceLabels[0] = title
                    }
                    if let formattedOccurrenceDate = occurrence.occurrenceDate?.format() {
                        nextController.occurrenceLabels[1] = formattedOccurrenceDate
                    }
                }
                //                if let occurrenceDate = ArrayHandler.sharedInstance.documentArray[indexPath.row].toOccurrence.occurrenceDate{
                //                    let formattedOccurrenceDate = occurrenceDate?.format()
                //                    nextController.occurrenceLabels.insert(formattedOccurrenceDate, at: 1)
                //                }
            }
         
            }
        if segue.identifier == "toPDFViewControllerFromDocsExportButton" {
            let nextController = segue.destination as! PDFViewController
            nextController.documentsToDisplay = ArrayHandler.sharedInstance.exportArray
        }
    }
}

//-----------------------------------------------------------

//MARK: - TableView Delegates -- See extension file

//MARK: - Seach Bar Delegates -- See extension file

