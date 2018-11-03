//
//  HomeViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: Global Variables
    var currentImage = UIImage()
    var imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func takePhotoPressed(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            showAlertForPhotoOrLibrary()
        }
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
                nextController.currentImage = currentImage
    }
}
}
