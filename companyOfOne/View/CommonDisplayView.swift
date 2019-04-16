//
//  CommonDisplayView.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class CommonDisplayView: UIView
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
    
    enum SearchBarScope {
        case isTitleTag
        case isCategory
        case isSubCategory
    }
    
    //MARK: - Instance Variables
    var exportMode:ExportMode = .off
    var selectedMode:SelectedMode = .noneSelected
    var searchBarScope:SearchBarScope = .isCategory
    var selectedTabIndex:Int = 0
    var exportDebugMode:Bool = false
    var tableViewDebugMode:Bool = false
    var searchBarDebugMode:Bool = true
    
    weak var delegate: MySegueDelegate?
    
    //MARK: - Property Observers
    var exportCountObserverForUIUpdates: Int = 0 {
        didSet {
            switch exportCountObserverForUIUpdates {
            case 0 :
                if exportMode == .on{
                    if exportDebugMode{
                        print("CommonDisplayView exportCountObserverForUIUpdates (property observer) reports: 0 selected for export\n")
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
                    if exportDebugMode{
                        print("CommonDisplayView exportCountObserverForUIUpdates reports: some selected for export\n")
                    }
                }
                filterButton.title = "Select All"
                pressedSharedButton.tintColor = nil
                selectedMode = .someSelected
            case ArrayHandler.sharedInstance.completeDocumentArray.count:
                if exportMode == .on{
                    if exportDebugMode{
                        print("CommonDisplayView exportCountObserverForUIUpdates reports: all selected for export\n")
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
                if exportDebugMode{
                    print("CommonDisplayView Share button pressed, Export mode on, none selected.\n")
                }
                print("TO DO: Run the alert function\n")
            case .someSelected:
                if exportDebugMode{
                    print("CommonDisplayView Share button pressed, Export mode on, \(ArrayHandler.sharedInstance.exportArray.count) items selected.\n")
                }
                print("TO DO: Run the export to PDF function here\n")
                //performSegue(withIdentifier: "toPDFViewControllerFromDocsExportButton", sender: self)
                self.delegate?.segueToPDFViewControllerCalled()
            case .allSelected:
                if exportDebugMode{
                    print("CommonDisplayView Share button pressed, Export mode on, \(ArrayHandler.sharedInstance.exportArray.count) items selected.\n")
                }
                print("TO DO: Run the export to PDF function here\n")
                self.delegate?.segueToPDFViewControllerCalled()
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
            if exportDebugMode{
                print("CommonDisplayView Filter Button Pressed, export mode off\n")
            }
            print("TO DO: Run the date filter function here\n")
        }
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

