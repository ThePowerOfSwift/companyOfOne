//
//  CommonDisplayView.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-28.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class CommonDisplayView: UIView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let kCONTENT_XIB_NAME = "CommonDisplayView"
    
    
    //CommonDisplayView puts together several items for display... the tableView, the searchBar, the exportButton, the filter button and the view title
    //completed: the search bar and the table view.  TODO: the nav title
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonSearchBar: UISearchBar!
    @IBOutlet weak var commonNavBar: UINavigationBar!
    
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
    
    // MARK:- TableView delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayHandler.sharedInstance.completeDocumentArray.count
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
    
    // MARK: SearchBar Delegates
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        commonSearchBar.showsCancelButton = true
        commonSearchBar.showsScopeBar = true
        commonSearchBar.scopeButtonTitles = ["Title/Tag", "Category", "Subcategory"]
        commonSearchBar.selectedScopeButtonIndex = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        FetchHandler.fetchFilteredDocuments(searchTerm: searchText)
        //commonDisplayView.commonTableView.reloadData()
        //print("current filter in textDidChange: \(FetchHandler.currentFilter)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("Beginning complete search from SearchButtonClicked")
        completeSearch()
        //print("Ending complete search from SearchButtonClicked")
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        //resetSearchBar()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //print("Beginning reset search from CancelButtonClicked")
        resetSearch()
        //print("Ending reset search from CancelButtonClicked")
    }
    
    public func resetSearch(){
        commonSearchBar.endEditing(true)
        commonSearchBar.showsCancelButton = false
        commonSearchBar.showsScopeBar = false
        resignFirstResponder()
        //updateViewControllerForSelectedTab()
    }
    
    func completeSearch(){
        commonSearchBar.endEditing(true)
        commonTableView.reloadData()
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

