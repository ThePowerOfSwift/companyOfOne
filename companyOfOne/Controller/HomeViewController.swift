//
//  HomeViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarControllerDelegate, UITabBarDelegate {
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var notificationCountLabel: UILabel!
    @IBOutlet weak var notificationIdentifierLabel: UILabel!
    @IBOutlet weak var deliveredNotificationsCountLabel: UILabel!
    @IBOutlet weak var deliveredNotificationDescriptionLabel: UILabel!
    
    //MARK: Global Variables
    var currentImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        navigationController?.title = "Home"
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    //MARK: - Actions
    
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
    
    @IBAction func takePhotoPressed(_ sender: UIBarButtonItem) {
        showAlertForPhotoOrLibrary()
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
