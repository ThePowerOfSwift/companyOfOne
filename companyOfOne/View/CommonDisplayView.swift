//
//  CommonDisplayView.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class CommonDisplayView: UIView
    //, UITableViewDataSource, UITableViewDelegate
   // ,UISearchBarDelegate
{
    
    let kCONTENT_XIB_NAME = "CommonDisplayView"
    
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
                    pressedSharedButton.image = #imageLiteral(resourceName: "upload")
                    pressedSharedButton.tintColor = nil
                    filterButton.image = #imageLiteral(resourceName: "filter")
                    filterButton.tintColor = nil
                }else{
                    pressedSharedButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
                }
            // TODO: - TO FIX: What happens when there is only one items --> Thread 1: Fatal error: Can't form Range with upperBound < lowerBound
            case 1...(ArrayHandler.sharedInstance.completeDocumentArray.count-1):
                if exportMode == .on{
                    if debugMode{
                        print("some selected for export")
                    }
                }
                filterButton.title = "Select All"
                pressedSharedButton.tintColor = nil
                selectedMode = .someSelected
            case ArrayHandler.sharedInstance.completeDocumentArray.count:
                if exportMode == .on{
                    if debugMode{
                        print("all selected for export")
                    }
                }
                pressedSharedButton.tintColor = nil
                filterButton.title = "Deselect All"
                selectedMode = .allSelected
            default: return
            }
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonSearchBar: UISearchBar!
    @IBOutlet weak var commonNavBar: UINavigationBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var pressedSharedButton: UIBarButtonItem!
    
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    //MARK: - Actions
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        switch exportMode {
        case .off:
            exportMode = .on
            pressedSharedButton.image = nil
            pressedSharedButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5)
            pressedSharedButton.title = "Export"
            filterButton.image = nil
            commonTableView?.allowsMultipleSelection = true
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
                 // TODO: - TO FIX: Why don't these segues work?
                //performSegue(withIdentifier: "toPDFViewControllerFromDocsExportButton", sender: self)
            case .allSelected:
                if debugMode{
                    print("export mode on, \(ArrayHandler.sharedInstance.exportArray.count) items selected:  run the export function ")
                }
                // TODO: - TO FIX: Why don't these segues work?
                //performSegue(withIdentifier: "toPDFViewControllerFromDocsExportButton", sender: self)
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
        let totalRows = commonTableView.numberOfRows(inSection: 0)
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            if item.isSelectedForExport == false {
                item.isSelectedForExport = true
                ArrayHandler.sharedInstance.exportArray.append(item)
            }
        }
        commonTableView.reloadData()
        //this selects all of the cells in the current display
        for row in 0..<totalRows {
            commonTableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
        //this propery observer updates state and UI
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
    
    func deSelectAllForExport(){
        //this clears the model objects isSelectedForExport bool and removes the exportArray
        let totalRows = commonTableView.numberOfRows(inSection: 0)
        for item in ArrayHandler.sharedInstance.completeDocumentArray {
            item.isSelectedForExport = false
        }
        
        //model updates should happen in the model but ... how?
        ArrayHandler.sharedInstance.exportArray.removeAll()
        commonTableView.reloadData()
        
        //this deselects all of the cells in the current display
        for row in 0..<totalRows {
            commonTableView.deselectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated:false)
        }
        ///this propery observer updates state and UI
        exportCountObserverForUIUpdates = ArrayHandler.sharedInstance.exportArray.count
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

