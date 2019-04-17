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
    
    //MARK: - Search Bar Delegates
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarTextDidBeginEditing (function) reports: function called\n")
        }
        commonSearchBar.showsCancelButton = true
        commonSearchBar.showsScopeBar = true
        commonSearchBar.scopeButtonTitles = ["Category", "Subcategory", "Title/Tag"]
        commonSearchBar.placeholder = "Search by category..."
        }

        //commonSearchBar.selectedScopeButtonIndex = commonSearchBar.selectedScopeButtonIndex

    
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
        commonSearchBar.placeholder = "Search your documents..."
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension searchBarCancelButtonClicked (function) reports: cancel button clicked\n")
        }
        resetSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            commonSearchBar.placeholder = "Search by category..."
            FetchHandler.updateSearchScope(searchScope: selectedScope)
            FetchHandler.fetchFilteredDocuments()
            commonTableView.reloadData()
        case 1:
            commonSearchBar.placeholder = "Search by subcategory..."
            FetchHandler.updateSearchScope(searchScope: selectedScope)
            FetchHandler.fetchFilteredDocuments()
            commonTableView.reloadData()
        case 2:
            commonSearchBar.placeholder = "Search by title/tag..."
            FetchHandler.updateSearchScope(searchScope: selectedScope)
            FetchHandler.fetchFilteredDocuments()
            commonTableView.reloadData()
        default:
            commonSearchBar.placeholder = "Search your documents..."
      
    }
    }
    
    //MARK: - Search Bar Custom Functions
    
    func resetSearch(){
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension resetSearch (function) reports: function called\n")
        }
        commonSearchBar.endEditing(true) //This calls searchBarShouldEndEditing
        commonSearchBar.text = nil
        commonSearchBar.showsScopeBar = false
        commonSearchBar.showsCancelButton = false
        resignFirstResponder()
        
        //TODO: TO FIX: This works but it is U-G-L-Y!!  I have this code in my tab bar, can't I just force a press?
        let application = UIApplication.shared.delegate as! AppDelegate
        let tabbarController = application.window?.rootViewController as! UITabBarController
        let selectedIndex = tabbarController.selectedIndex
        switch selectedIndex {
        case 1:
            if searchBarDebugMode{
                print("Current selected index for tab:\(selectedIndex)")
            }
            FetchHandler.updateSearchScope(searchScope: 0)
            commonSearchBar.selectedScopeButtonIndex = 0
            FetchHandler.updateSearchText(searchText: "All But Mail And Receipts")
            FetchHandler.fetchFilteredDocuments()
        case 2:
            if searchBarDebugMode{
                print("Current selected index for tab:\(selectedIndex)")
            }
            FetchHandler.updateSearchScope(searchScope: 0)
            commonSearchBar.selectedScopeButtonIndex = 0
            FetchHandler.updateSearchText(searchText: "Mail")
            FetchHandler.fetchFilteredDocuments()
        case 3:
            if searchBarDebugMode{
                print("Current selected index for tab:\(selectedIndex)")
            }
            FetchHandler.updateSearchScope(searchScope: 0)
            commonSearchBar.selectedScopeButtonIndex = 0
            FetchHandler.updateSearchText(searchText: "Receipts")
            FetchHandler.fetchFilteredDocuments()
        default:
            print("ERROR: Default code run")
        }
        commonTableView.reloadData()
    }
    
    func completeSearch(){
        if searchBarDebugMode{
            print("CommonDisplayView_SeachBarExtension completeSearch (function) reports: function called\n")
        }
        commonSearchBar.endEditing(true) //This calls searchBarShouldEndEditing
        (commonSearchBar.value(forKey: "_cancelButton") as? UIButton)?.isEnabled = true
    }
}

// Here is how I would like the search bar to work:
// for each scope tab, you can enter in a seach term and all three would be used
// for Mail and Receipts tabs, in the seach bar with the category scope, it would be autopopulated and greyed out.
//
