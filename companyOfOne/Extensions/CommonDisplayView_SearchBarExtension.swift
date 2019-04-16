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
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarTextDidBeginEditing (function) reports: function called\n")
        }
        commonSearchBar.showsCancelButton = true
        commonSearchBar.showsScopeBar = true
        commonSearchBar.scopeButtonTitles = ["Category", "Subcategory", "Title/Tag"]
        commonSearchBar.selectedScopeButtonIndex = commonSearchBar.selectedScopeButtonIndex
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension textDidChange (function) reports: function called\n")
        }
        //This passes the info to the FetchHandler
        FetchHandler.updateSearchScope(searchScope: commonSearchBar.selectedScopeButtonIndex)
        FetchHandler.updateSearchText(searchText: searchText)
        FetchHandler.fetchFilteredDocuments()
        commonTableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarSearchButtonClicked (function) reports: done button clicked\n")
        }
        completeSearch()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarShouldEndEditing (function) reports: function called\n")
        }
        //resetSearchBar()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarCancelButtonClicked (function) reports: cancel button clicked\n")
        }
        resetSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        FetchHandler.updateSearchScope(searchScope: selectedScope)
        FetchHandler.fetchFilteredDocuments()
        commonTableView.reloadData()
    }
    
    //MARK: - Search Bar Custom Functions
    
    func resetSearch(){
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension resetSearch (function) reports: function called\n")
        }
        commonSearchBar.endEditing(true) //This calls searchBarShouldEndEditing
        commonSearchBar.showsCancelButton = false
        commonSearchBar.showsScopeBar = false
        resignFirstResponder()
        //TODO: TO FIX: How do I get the selected tab from here?  I need it to refresh when there are no seach results back to the tab search
        let tabBarController = TabBarController()
        let selectedTab = tabBarController.selectedIndex
        FetchHandler.updateSearchScope(searchScope: selectedTab)
        FetchHandler.fetchFilteredDocuments()
        //commonTableView.reloadData()
        
    }
    
    func completeSearch(){
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension completeSearch (function) reports: function called\n")
        }
        commonSearchBar.endEditing(true) //This calls searchBarShouldEndEditing
    }
    }

// Here is how I would like the search bar to work:
// for each scope tab, you can enter in a seach term and all three would be used
// for Mail and Receipts tabs, in the seach bar with the category scope, it would be autopopulated and greyed out.
//
