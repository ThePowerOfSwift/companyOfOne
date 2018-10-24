//
//  HomeViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

protocol CategoryDelegate {
    //add category to array from categoryViewController, pass back updated array to HomeViewController, update editViewController
    func returnMainArray(array:[Category])
}

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: Global Variables
    var currentImage = UIImage()
    var delegate: CategoryDelegate?
    var allCategoriesSubCategories = [Category]()
    //var currentCategory = Category(name: "To Be Categorized")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // allCategoriesSubCategories.append(currentCategory)
//        let categoryManager = CategoryManager()
//        allCategoriesSubCategories = categoryManager.categoryArray
        updateArrayForCategoryViewController()
    }
    
    @IBAction func takePhotoPressed(_ sender: UIBarButtonItem) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        currentImage = image
    }
    
    func updateArrayForCategoryViewController(){
        delegate?.returnMainArray(array: allCategoriesSubCategories)
    }
}

