//
//  ReceiptsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ReceiptsViewController: UIViewController, MySegueDelegate {
    
    
    func segueToEditViewControllerCalled() {
        performSegue(withIdentifier: "toEditViewControllerFromReceipts", sender: self)
    }
    func segueToPDFViewControllerCalled() {
        performSegue(withIdentifier: "toPDFViewControllerFromReceiptsExportButton", sender: self)
    }
    
    
    //This is the template for the new way of doing multiple view controllers sharing a view.
    
    //MARK: - Constants
    let customView = CommonDisplayView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        createTotalView()
        registerTableViewNibs()
        updateNavBarTitleAndHiddenStatus()
        customView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
        updateNavBarTitleAndHiddenStatus()
        confirmAllValues()
    }
    
    
    
    func createTotalView(){
        if let bounds = parent?.view.bounds {
            customView.frame = bounds
        }
        self.view.addSubview(customView)
        customView.exportMode = .off
    }
    
    func registerTableViewNibs(){
        let nib = UINib(nibName: "CommonTableViewCell", bundle: nil)
        customView.commonTableView.register(nib, forCellReuseIdentifier: "commonTableViewCell")
    }
    
    func updateNavBarTitleAndHiddenStatus(){
        navigationController!.isNavigationBarHidden = true
        customView.commonNavBar.topItem?.title = "Personal Receipts"
        
    }
    
    func updateTableView(){
        customView.setupTableViewForPopulation()
    }
    
    func confirmAllValues(){
        if customView.debugMode{
            print("\(self) viewWillAppear confirming export mode is \(customView.exportMode).\n")
            print("\(self) viewWillAppear confirming selected mode is \(customView.selectedMode).\n")
            print("\(self) viewWillAppear confirming that \(customView.exportCountObserverForUIUpdates) documents are selected for export\n")
        }
    }
    
    //MARK: - Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditViewControllerFromReceipts" {
            if let indexPath = customView.commonTableView.indexPathForSelectedRow {
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
        if segue.identifier == "toPDFViewControllerFromReceiptsExportButton" {
            let nextController = segue.destination as! PDFViewController
            nextController.documentsToDisplay = ArrayHandler.sharedInstance.exportArray
        }
    }
}

