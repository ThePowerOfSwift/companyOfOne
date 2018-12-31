//
//  DocumentSearchBar.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-31.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocumentSearchBar: UISearchBar, UISearchBarDelegate {
    
   // let commonDisplayView = CommonDisplayView()

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
        self.showsScopeBar = true
        self.scopeButtonTitles = ["Title/Tag", "Category", "Subcategory"]
        self.selectedScopeButtonIndex = 0
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
       self.endEditing(true)
        self.showsCancelButton = false
        self.showsScopeBar = false
        resignFirstResponder()
        //updateViewControllerForSelectedTab()
    }
    
    func completeSearch(){
        self.endEditing(true)
       // commonDisplayView.commonTableView.reloadData()
    }
}
