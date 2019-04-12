//
//  HomeViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarControllerDelegate, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var reminderTableView: UITableView!
    @IBOutlet weak var notificationCountLabel: UILabel!
    @IBOutlet weak var notificationIdentifierLabel: UILabel!
    @IBOutlet weak var deliveredNotificationsCountLabel: UILabel!
    @IBOutlet weak var deliveredNotificationDescriptionLabel: UILabel!
    
    //MARK: Global Variables
    var currentImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
//        if let tabItems = tabBarController?.tabBar.items {
//            // In this case we want to modify the badge number of the tab:
//            tabItems[2].badgeValue = "1"
//        }
        registerNibs()
        let navbar = navigationController
        navbar!.title = "Home"
       // self.navigationController?.title = "Home"
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //temp population data!!! This will eventually be the list of occurrence notifications
        FetchHandler.fetchFilteredDocuments(searchTerm: "Receipts") //temp population data!!! This
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            tabItems[0].badgeValue = "1"
        }
    }
    
    
    func registerNibs(){
        let nib = UINib(nibName: "CommonTableViewCell", bundle: nil)
        reminderTableView.register(nib, forCellReuseIdentifier: "commonTableViewCell")
    }
    
    //MARK: - Notification Actions
    
    @IBAction func pressedGetDeliveredNotificationsButton(_ sender: UIButton) {
        LocalNotificationHandler.updateDeliveredNotificationInfo { (count
            , descripts) in
            DispatchQueue.main.async {
                self.updateUIForDeliveredNotifications(count: count, descripts: descripts)
            }
        }
    }
    
    @IBAction func pressedClearSpecificDeliveredNotificationButton(_ sender: UIButton) {
        print("clear specific delivered notification")
    }
    
    @IBAction func pressedClearAllDeliveredNotificationsButton(_ sender: UIButton) {
        print("clear all delivered notification")
    }
    
    
    @IBAction func pressedClearAllNotifications(_ sender: UIButton) {
        //clear pending notifications
        LocalNotificationHandler.clearAllPendingNotifications()
        //update UI
        notificationCountLabel.text = "0"
        notificationIdentifierLabel.text = ""
    }
    
    @IBAction func pressedScheduleNotification(_ sender: UIButton){
        print("schedule notification button pressed")
        LocalNotificationHandler.scheduleNotification()
        LocalNotificationHandler.updatePendingNotificationInfo { (count, identifiers) in
            let countString = ("\(count)")
            DispatchQueue.main.async {
                self.notificationCountLabel.text = countString
                self.notificationIdentifierLabel.text = identifiers.joined(separator: ", ")
            }
        }
    }
    
    //MARK: - Button Press Actions
    
    @IBAction func takePhotoPressed(_ sender: UIBarButtonItem) {
        showAlertForPhotoOrLibrary()
    }
    
    //MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ArrayHandler.sharedInstance.completeDocumentArray.count != 0{
            return ArrayHandler.sharedInstance.completeDocumentArray.count
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "commonTableViewCell")! as! CommonTableViewCell
        //TODO: FIX THIS: With no items in the array, new installs crash
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
//        if let imageData = ArrayHandler.sharedInstance.completeDocumentArray[indexPath.row].pictureData {
//            cell.docImageView.image = UIImage(data: imageData)
//        }
        return cell
    }
    
    //this function can be used by the LocalNotifcationHandler or a future PushNotificationHandler
    func updateUIForDeliveredNotifications(count: Int, descripts: [String]){
        let countString = ("\(count)")
        self.deliveredNotificationsCountLabel.text = countString
        self.deliveredNotificationDescriptionLabel.text = descripts.joined(separator: ", ")
    }
    
    func takeAPhoto(){
        print("took a photo")
        imagePicker.sourceType = .camera
        //imagePicker.allowsEditing = true
        //imagePicker.showsCameraControls = true
        present(imagePicker, animated: true)
        
    }
    func pickFromLibrary(){
        print("pick from library")
        imagePicker.sourceType = .photoLibrary
        //imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func showAlertForPhotoOrLibrary(){
        let alert = UIAlertController(title: "Add Document Image",
                                      message: "Would you like to take a photo or pick from your library?",
                                      preferredStyle: .alert)
        let takeAPhotoAction = UIAlertAction(title: "Take A Photo", style: .default, handler: { action in
            self.takeAPhoto()
        })
        
        let pickFromLibraryAction = UIAlertAction(title: "Pick From Library", style: .default, handler: { action in
            self.pickFromLibrary()
        })
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addAction(takeAPhotoAction)
        alert.addAction(pickFromLibraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        currentImage = image
        performSegue(withIdentifier: "toEditViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditViewController" {
            let nextController = segue.destination as! EditViewController
            nextController.fromDocsViewController = false
            nextController.currentImage = currentImage
        }
    }
}
