//
//  TableViewExtension_CommonDisplayView.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-29.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit

extension CommonDisplayView: UITableViewDelegate,UITableViewDataSource {
    
    func setupTableViewForPopulation(){
        commonTableView.allowsMultipleSelection = false
        
        //makes sure the enums are reset
        exportMode = .off
        selectedMode = .noneSelected
        //clears the export Array and deselect all items/cells
        deSelectAllForExport()
        commonTableView.reloadData()
    }
    
    //MARK: - Export Functions
    
    func selectAllForExport(){
        if exportDebugMode{
            print("CommonDisplayView_TableViewExtension reports: selectAllForExport function run with the following results:\n")
        }
        let totalRows = commonTableView.numberOfRows(inSection: 0)
        //for each item in the completeDocumentArray
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            //this toggles the model objects isSelectedForExport bool
            if item.isSelectedForExport == false {
                item.isSelectedForExport = true
                //this adds the item to the exportArray
                ArrayHandler.sharedInstance.exportArray.append(item)
            }
        }
        commonTableView.reloadData()
        //this changes the UI color of all of the cells in the current display to reflected selected status
        for row in 0..<totalRows {
            commonTableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
        //Sets the propery observer to exportArray.count which will update the view UI for export workflow
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    func deSelectAllForExport(){
        if exportDebugMode{
            print("CommonDisplayView_TableViewExtension reports: deSelectAllForExport function run with the following results:\n")
        }
        let totalRows = commonTableView.numberOfRows(inSection: 0)
        //for each item in the completeDocumentArray
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            //this sets the model objects isSelectedForExport bool to false
            item.isSelectedForExport = false
        }
        //this clears the exportArray
        ArrayHandler.sharedInstance.exportArray.removeAll()
        commonTableView.reloadData()
        
        //this changes the UI color of all of the cells in the current display to reflected deselected status
        for row in 0..<totalRows {
            commonTableView.deselectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated:false)
        }
        //Sets the propery observer to exportArray.count which will update the view UI for export workflow
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    //MARK: - TableView Delegate Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayHandler.sharedInstance.completeDocumentArray.count//?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commonTableViewCell")! as! CommonTableViewCell
        if tableViewDebugMode{
            print("CommonDisplayView_TableViewExtension reports: ArrayHandler.sharedInstance.completeDocumentArray has \(ArrayHandler.sharedInstance.completeDocumentArray.count) objects in it")
        }
        cell.isSelectedForExport = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].isSelectedForExport
        if cell.isSelectedForExport{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        cell.titleTagLabel.text = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].titleTag
        cell.categoryLabel.text = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].toCategory?.name
        cell.subCategoryLabel.text = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].toSubCategory?.name
        cell.dateLabel.text = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].documentDate?.format()
        //cell.occurenceLabel.text = document?.occurrence?
        if let imageData = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].pictureData {
            cell.docImageView.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FetchHandler.deleteDocumentAndFetchFilteredDocuments(document: ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch exportMode {
        case .on:
            //update UI, update model and add to exportArray
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                cell.accessoryType = .checkmark
                ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].isSelectedForExport = true
                ArrayHandler.sharedInstance.exportArray.append(ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row])
                //this propery observer updates state and UI
                exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
            }
        case .off:
            self.delegate?.segueToEditViewControllerCalled()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //update UI, update model and remove from exportArray
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .disclosureIndicator
            ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].isSelectedForExport = false
            if let index = ArrayHandler.sharedInstance.exportArray.firstIndex(of: ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row]) {
                ArrayHandler.sharedInstance.exportArray.remove(at: index)
            }
            //this propery observer updates state and UI
            exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
        }
    }
}
