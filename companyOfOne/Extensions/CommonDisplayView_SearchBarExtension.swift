//
//  SearchBarExtenstion_CommonDisplayView.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-29.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import UIKit

// so first fetch scoped documents
// then fetch searchTerm filtered documents from that array

extension CommonDisplayView: UISearchBarDelegate {
   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        commonSearchBar.showsCancelButton = true
        commonSearchBar.showsScopeBar = true
        commonSearchBar.scopeButtonTitles = ["Category", "Subcategory", "Title/Tag"]
        commonSearchBar.selectedScopeButtonIndex = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarDebugMode{
            print("\(self) textDidChange\n")
        }
        
        //This passes the info to the FetchHandler
        FetchHandler.fetchSearchScope(searchScope: commonSearchBar.selectedScopeButtonIndex)
        FetchHandler.fetchSearchText(searchText: searchText)

        FetchHandler.fetchFilteredDocuments()

        commonTableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("\(self) seachBarSearchButtonClicked\n")
        }
        completeSearch()

        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBarDebugMode{
            print("\(self) searchBarShouldEndEditing\n")
        }
        //resetSearchBar()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("\(self) searchBarCancelButtonClicked\n")
        }
        resetSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        FetchHandler.fetchSearchScope(searchScope: selectedScope)
        FetchHandler.fetchFilteredDocuments()
        commonTableView.reloadData()
    }
    
    func collectSearchText(searchText:String) {
        
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

// Here is how I would like the search bar to work:
// for each scope tab, you can enter in a seach term and all three would be used
// for Mail and Receipts tabs, in the seach bar with the category scope, it would be autopopulated and greyed out.
//
