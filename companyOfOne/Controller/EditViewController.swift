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
    
    //var centerContstraintX = NSLayoutConstraint()
    var titleTagLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var titleTagLabelTrailingAnchorToCenterX = NSLayoutConstraint()
    var titleTagTextFieldLeadingAnchorToTrailingAnchor = NSLayoutConstraint()
    var titleTagTextFieldLeadingAnchorToCenterX = NSLayoutConstraint()
    var categorySubCategoryLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var categorySubCategoryLabelTrailingAnchorToCenterX = NSLayoutConstraint()
    var categoryPickerViewLeadingAnchorToTrailingAnchor = NSLayoutConstraint()
    var categoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDocTitleTagLabel()
        setupDocTitleTagTextField()
        setupCategorySubCategoryLabel()
        setupCategoryPicker()
        addSwipeGuesturesForDocTitle()
        addSwipeGuesturesForCategorySubCategory()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Setup Gesture Recognizers
    
    func addSwipeGuesturesForDocTitle(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        titleTagLabel.addGestureRecognizer(leftSwipe)
        titleTagTextField.addGestureRecognizer(rightSwipe)
    }
    
    func addSwipeGuesturesForCategorySubCategory(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnCategorySubCategoryLabelShowsAndHidesCategoryPicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnCategorySubCategoryLabelShowsAndHidesCategoryPicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        categorySubCategoryLabel.addGestureRecognizer(leftSwipe)
        categoryPickerView.addGestureRecognizer(rightSwipe)
    }
    
    //MARK: Setup Title and Constraints
    
    func setupDocTitleTagLabel(){
        let topOffset = view.frame.height/5
        titleTagLabel.isUserInteractionEnabled = true
        titleTagLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        titleTagLabel.alpha = 0.7
        titleTagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTagLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true
        titleTagLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTagLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated
        titleTagLabelLeadingAnchorToCenterX = titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        titleTagLabelLeadingAnchorToCenterX.isActive = true
        titleTagLabelTrailingAnchorToCenterX = titleTagLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor)
        titleTagLabelTrailingAnchorToCenterX.isActive = false
        
    }
    
    func setupDocTitleTagTextField(){
        let topOffset = view.frame.height/5
        titleTagTextField.isUserInteractionEnabled = true
        titleTagTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTagTextField.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        titleTagTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTagTextField.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated
        titleTagTextFieldLeadingAnchorToTrailingAnchor = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        titleTagTextFieldLeadingAnchorToTrailingAnchor.isActive = true
        titleTagTextFieldLeadingAnchorToCenterX = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        titleTagTextFieldLeadingAnchorToCenterX.isActive = false
    }
    
    func setupCategorySubCategoryLabel(){
        let topOffset = view.frame.height/5 * 2
        categorySubCategoryLabel.isUserInteractionEnabled = true
        categorySubCategoryLabel.backgroundColor = #colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1)
        categorySubCategoryLabel.alpha = 0.7
        categorySubCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categorySubCategoryLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true
        categorySubCategoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categorySubCategoryLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated
        categorySubCategoryLabelLeadingAnchorToCenterX = categorySubCategoryLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        categorySubCategoryLabelLeadingAnchorToCenterX.isActive = true
        categorySubCategoryLabelTrailingAnchorToCenterX = categorySubCategoryLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor)
        categorySubCategoryLabelTrailingAnchorToCenterX.isActive = false
        
    }
    
    func setupCategoryPicker(){
        let topOffset = view.frame.height/5 * 2
        let sizeOffset = view.frame.height/5
        categoryPickerView.isUserInteractionEnabled = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerView.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        categoryPickerView.heightAnchor.constraint(equalToConstant: sizeOffset).isActive = true
        categoryPickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated
        categoryPickerViewLeadingAnchorToTrailingAnchor = categoryPickerView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        categoryPickerViewLeadingAnchorToTrailingAnchor.isActive = true
        categoryPickerViewLeadingAnchorToCenterX = categoryPickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        categoryPickerViewLeadingAnchorToCenterX.isActive = false
    }
    
    func setupSubCategoryPicker(){
        //        let topOffset = view.frame.height/5
        //        titleTagTextField.isUserInteractionEnabled = true
        //        titleTagTextField.translatesAutoresizingMaskIntoConstraints = false
        //        titleTagTextField.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        //        titleTagTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //        titleTagTextField.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        //
        //        //these are the global constraints to be animated
        //        titleTagTextFieldLeadingAnchorToTrailingAnchor = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        //        titleTagTextFieldLeadingAnchorToTrailingAnchor.isActive = true
        //        titleTagTextFieldLeadingAnchorToCenterX = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        //        titleTagTextFieldLeadingAnchorToCenterX.isActive = false
    }
    
    
    
    //MARK: Title Swipe Function
    
    @objc func swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on titleTag label")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabelLeadingAnchorToCenterX.isActive = false
                    self.titleTagLabelTrailingAnchorToCenterX.isActive = true
                    self.titleTagTextFieldLeadingAnchorToTrailingAnchor.isActive = false
                    self.titleTagTextFieldLeadingAnchorToCenterX.isActive = true
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on titleTag text input")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabelTrailingAnchorToCenterX.isActive = false
                    self.titleTagLabelLeadingAnchorToCenterX.isActive = true
                    self.titleTagTextFieldLeadingAnchorToCenterX.isActive = false
                    self.titleTagTextFieldLeadingAnchorToTrailingAnchor.isActive = true
                    
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
    @objc func swipeOnCategorySubCategoryLabelShowsAndHidesCategoryPicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on category label")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.isActive = false
                    self.categorySubCategoryLabelTrailingAnchorToCenterX.isActive = true
                    self.categoryPickerViewLeadingAnchorToTrailingAnchor.isActive = false
                    self.categoryPickerViewLeadingAnchorToCenterX.isActive = true
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on category picker")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelTrailingAnchorToCenterX.isActive = false
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.isActive = true
                    self.categoryPickerViewLeadingAnchorToCenterX.isActive = false
                    self.categoryPickerViewLeadingAnchorToTrailingAnchor.isActive = true
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    
    
            
 

    func setupReoccurancePicker(){
        
    }
    func setupDocDatePicker(){
        
    }
}

