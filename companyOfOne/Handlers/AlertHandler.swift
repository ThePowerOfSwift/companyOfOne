//
//  AlertHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-17.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

//TODO: - I think I can use class functions instead of singleton for this

class AlertHandler: NSObject {
    static let sharedInstance = AlertHandler()
    override private init() {}
    func getNameAlert(title: String, message: String, viewController: UIViewController) -> String {
        var name = String()
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default)
        guard let textField = alert.textFields?.first else {return "No name"}
        name = textField.text ?? "default name (alert)"
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true)
        return name
    }
}
