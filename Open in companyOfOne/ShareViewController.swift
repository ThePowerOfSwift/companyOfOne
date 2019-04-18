//
//  ShareViewController.swift
//  Open in companyOfOne
//
//  Created by Jamie on 2019-04-18.
//  Copyright © 2019 Jamie. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
//        let navSize = self.navigationController?.navigationBar.frame.size
////        self.navigationController?.navigationBar.setBackgroundImage(getTopWithColor(UIColor.whiteColor(), size: navSize!), forBarMetrics: .Default)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let table = textView.superview?.superview?.superview as? UITableView {
            let length = table.numberOfRows(inSection: 0)
            table.scrollToRow(at: IndexPath(row: length - 1, section: 0), at: .bottom, animated: true)
            
            if let row = table.cellForRow(at: IndexPath(item: 0, section: 0)) {
                row.backgroundColor?.withAlphaComponent(0.5)
                row.backgroundColor = #colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1)
                row.backgroundColor?.withAlphaComponent(0.5)
                
            }
            if let row = table.cellForRow(at: IndexPath(item: 1, section: 0)) {
                row.backgroundColor?.withAlphaComponent(0.5)
                row.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            if let row = table.cellForRow(at: IndexPath(item: 2, section: 0)) {
                row.backgroundColor?.withAlphaComponent(0.5)
                row.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
        }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        var configItems = [SLComposeSheetConfigurationItem]()
 
        if let category = SLComposeSheetConfigurationItem() {
            category.title = "Category:SubCategory"
            //category.value = "This has to be populated by the category array from my app"
            category.tapHandler = {
                self.performSegue(withIdentifier: "toShareEditViewContoller", sender: Any?.self)
                print("This is what happens when a config item is tapped")
            }
            configItems.append(category)
        }
        if let occurrence = SLComposeSheetConfigurationItem() {
            occurrence.title = "Occurrence"
            //occurrence.value = "Date picker needed here"
            occurrence.tapHandler = {
                print("This is what happens when a config item is tapped")
            }
            configItems.append(occurrence)
        }
        if let documentDate = SLComposeSheetConfigurationItem() {
            documentDate.title = "Document Date"
            //documentDate.value = "Date picker needed here"
            documentDate.tapHandler = {
                print("This is what happens when a config item is tapped")
            }
            configItems.append(documentDate)
        }
        return configItems
    }

}
