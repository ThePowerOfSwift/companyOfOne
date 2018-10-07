//
//  EditViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    
    
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var titleTagTextField: UITextField!
    @IBOutlet weak var categorySubCategoryLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var subCategoryPickerView: UIPickerView!
    @IBOutlet weak var occuranceLabel: UILabel!
    @IBOutlet weak var occurancePickerView: UIPickerView!
    @IBOutlet weak var docDateLabel: UILabel!
    @IBOutlet weak var DocDatePickerView: UIDatePicker!
    
    var centerContstraintX = NSLayoutConstraint()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDocTitleTagLabel()
        setupDocTitleTagTextField()
        addSwipeGuesturesForDocTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addSwipeGuesturesForDocTitle(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        titleTagLabel.addGestureRecognizer(leftSwipe)
        titleTagLabel.addGestureRecognizer(rightSwipe)
    }
    
    func setupDocTitleTagLabel(){
        
        let topOffset = view.frame.height/5
        titleTagLabel.isUserInteractionEnabled = true
        titleTagLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        titleTagLabel.alpha = 0.7
        titleTagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTagLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true
        titleTagLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleTagLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
    }
    
    func setupDocTitleTagTextField(){
        let topOffset = view.frame.height/5
        titleTagTextField.isUserInteractionEnabled = true
        titleTagTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTagTextField.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        titleTagTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleTagTextField.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
    }
    
    @objc func swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left")
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
                    self.titleTagLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = false
                    self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right")
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
                    self.titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
                    self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
//    func swipeLeftOnDocTitleTagOrTitleTagTextFieldHidesTitleTagTextField(){
//        DispatchQueue.main.async {[unowned self] in
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
//                self.titleTagLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
//                self.titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//                self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
//                self.titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//                self.view.layoutIfNeeded()
//            })
//        }
//    }
    
    
            
    func setupSubCategoryPicker(){
        
    }
    func setupCategoryPicker(){
        
    }
    func setupReoccurancePicker(){
        
    }
    func setupDocDatePicker(){
        
    }
}

