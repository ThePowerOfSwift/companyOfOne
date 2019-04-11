//
//  TableViewExtension_DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-29.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit

extension DocsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayHandler.sharedInstance.completeDocumentArray.count//?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docViewTableViewCell")! as! DocViewTableViewCell
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
            performSegue(withIdentifier: "toEditViewControllerFromDocs", sender: self)
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
