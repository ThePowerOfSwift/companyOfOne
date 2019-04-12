//
//  SearchBarExtenstion_DocsViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-29.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit

extension CommonDisplayView: UISearchBarDelegate {
//    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        commonSearchBar.showsCancelButton = true
        commonSearchBar.showsScopeBar = true
        commonSearchBar.scopeButtonTitles = ["Title/Tag", "Category", "Subcategory"]
        commonSearchBar.selectedScopeButtonIndex = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        FetchHandler.fetchFilteredDocuments(searchTerm: searchText)
        //FetchHandler.currentFilter = searchText
        // document.retrieveAllDocuments(filteredBy: "\(FetchHandler.currentFilter)")
        commonTableView.reloadData()
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
    
    //MARK: - Search Bar Custom Functions
    
    func resetSearch(){
        commonSearchBar.endEditing(true)
        commonSearchBar.showsCancelButton = false
        commonSearchBar.showsScopeBar = false
        resignFirstResponder()
        //updateViewControllerForSelectedTab()
        
    }
    
    func completeSearch(){
        //document.retrieveAllDocuments(filteredBy: "\(FetchHandler.currentFilter)")
        commonSearchBar.endEditing(true)
        commonTableView.reloadData()
    }
}
