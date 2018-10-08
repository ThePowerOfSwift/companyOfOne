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
    
    
    var xPosition1 = CGFloat()
    var xPosition2 = CGFloat()
    var xPosition3 = CGFloat()
    var xPosition4 = CGFloat()
    var xPosition5 = CGFloat()
    var yPosition1 = CGFloat()
    var yPosition2 = CGFloat()
    var yPosition3 = CGFloat()
    var yPosition4 = CGFloat()
    var allWidthConstant = CGFloat()
    var labelHeightConstant = CGFloat()
    var pickerHeightConstant = CGFloat()
    
    var titleTagLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    //var titleTagLabelTrailingAnchorToCenterX = NSLayoutConstraint()
    //var titleTagTextFieldLeadingAnchorToTrailingAnchor = NSLayoutConstraint()
    var titleTagTextFieldLeadingAnchorToCenterX = NSLayoutConstraint()
    var categorySubCategoryLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    //var categorySubCategoryLabelTrailingAnchorToCenterX = NSLayoutConstraint()
    //var categoryPickerViewLeadingAnchorToTrailingAnchor = NSLayoutConstraint()
    var categoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    //var subCategoryPickerViewLeadingAnchorToTrailingAnchor = NSLayoutConstraint()
    var subCategoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupX_Y_W_H_Constants()
        setupDocTitleTagLabel()
        setupDocTitleTagTextField()
        setupCategorySubCategoryLabel()
        setupCategoryPicker()
        setupSubCategoryPicker()
        addSwipeGuesturesForDocTitle()
        addSwipeGuesturesForCategorySubCategory()
        addSwipeGuesturesForSubCategory()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupX_Y_W_H_Constants(){
        xPosition1 = -1*(view.frame.width)
        xPosition2 = -1*(view.frame.width/2)
        xPosition3 = 0
        xPosition4 = view.frame.width/2
        xPosition5 = view.frame.width
        
        yPosition1 = 1*(view.frame.height/5)
        yPosition2 = 2*(view.frame.height/5)
        yPosition3 = 3*(view.frame.height/5)
        yPosition4 = 4*(view.frame.height/5)
        
        allWidthConstant = view.frame.width/2
        
        labelHeightConstant = 30
        pickerHeightConstant = view.frame.height/5
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
    
    func addSwipeGuesturesForSubCategory(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnCategoryPickerShowsAndHidesSubCategoryPicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnCategoryPickerShowsAndHidesSubCategoryPicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        categoryPickerView.addGestureRecognizer(leftSwipe)
        subCategoryPickerView.addGestureRecognizer(rightSwipe)
    }
    
    //MARK: Setup Title and Constraints
    
    func setupDocTitleTagLabel(){
        //setup in xPosition 3, yPositon 1
        titleTagLabel.isUserInteractionEnabled = true
        titleTagLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        titleTagLabel.alpha = 0.4
        titleTagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTagLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        titleTagLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        titleTagLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition1).isActive = true
        
        //this the global constraints to be animated
        titleTagLabelLeadingAnchorToCenterX = titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        titleTagLabelLeadingAnchorToCenterX.isActive = true
    }
    
    func setupDocTitleTagTextField(){
        //setup in xPosition 4, yPosition 1
        titleTagTextField.isUserInteractionEnabled = true
        titleTagTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTagTextField.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        titleTagTextField.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        titleTagTextField.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition1).isActive = true
        
        //this isthe global constraints to be animated
        titleTagTextFieldLeadingAnchorToCenterX = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        titleTagTextFieldLeadingAnchorToCenterX.isActive = true
    }
    
    func setupCategorySubCategoryLabel(){
        //setup in xPosition 3, yPosition2
        let topOffset = view.frame.height/5 * 2
        categorySubCategoryLabel.isUserInteractionEnabled = true
        categorySubCategoryLabel.backgroundColor = #colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1)
        categorySubCategoryLabel.alpha = 0.4
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
        //setup in position 4
        let topOffset = view.frame.height/5 * 2
        let sizeOffset = view.frame.height/5
        categoryPickerView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        categoryPickerView.isUserInteractionEnabled = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerView.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        categoryPickerView.heightAnchor.constraint(equalToConstant: sizeOffset).isActive = true
        categoryPickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated bring it onto the right side of the view
        categoryPickerViewLeadingAnchorToTrailingAnchor = categoryPickerView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        categoryPickerViewLeadingAnchorToTrailingAnchor.isActive = true
        categoryPickerViewLeadingAnchorToCenterX = categoryPickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor)
        categoryPickerViewLeadingAnchorToCenterX.isActive = false
        
        //these are the global constraints to be animated bringing it onto the left side of the view
        //leading anchor to leading anchor should move it to the left
        //just update the constant to -view/2?
    }
    
    func setupSubCategoryPicker(){
        //setup in position 5
        let topOffset = view.frame.height/5 * 3
        let sizeOffset = view.frame.height/5
        let rightLocationOffset = view.frame.width/2
        categoryPickerView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        subCategoryPickerView.isUserInteractionEnabled = true
        subCategoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        subCategoryPickerView.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        subCategoryPickerView.heightAnchor.constraint(equalToConstant: sizeOffset).isActive = true
        subCategoryPickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: topOffset).isActive = true
        
        //these are the global constraints to be animated bringing it one step closer to the view
        subCategoryPickerViewLeadingAnchorToTrailingAnchor = subCategoryPickerView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: rightLocationOffset)
        subCategoryPickerViewLeadingAnchorToTrailingAnchor.isActive = true
        subCategoryPickerViewLeadingAnchorToCenterX = subCategoryPickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: rightLocationOffset)
        subCategoryPickerViewLeadingAnchorToCenterX.isActive = false
        
         //these are the global constraints to be animated bringing it onto the right side of the view
        //just update the constant in the animation to zero??
        
    }
    
    
    
    //MARK: Title Swipe Function
    
    @objc func swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on titleTag label")
                //titleTagLabel moved to postion 2, titleTagTextInput moved to position 3
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.titleTagTextFieldLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on titleTag text input")
                //titleTagLabel moved to postion 3, titleTagTextInput moved to position 4
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabelLeadingAnchorToCenterX.constant = self.xPosition3
                    self.titleTagTextFieldLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
    @objc func swipeOnCategorySubCategoryLabelShowsAndHidesCategoryPicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on category label")
                //categoryLabel moved to postion 2, categoryPicker moved to position 3
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
                //categoryLabel moved to postion 3, categoryPicker moved to position 4
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
    
    @objc func swipeOnCategoryPickerShowsAndHidesSubCategoryPicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left categoryPicker")
                //categorySubCategoryLabel moved to postion 1, categoryPicker moved to postion 2, categoryPicker moved to position 3
                let negativeWidthOffset = -1 * (self.view.frame.width/2)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    
                    //moves the categorySubCategoryLabel off the view to the left
                    self.categorySubCategoryLabelTrailingAnchorToCenterX.constant = negativeWidthOffset
                    
                    //moves the category to the left
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = negativeWidthOffset
                    
                    //moves the sub category onto the view
                    self.subCategoryPickerViewLeadingAnchorToTrailingAnchor.isActive = false
                    self.subCategoryPickerViewLeadingAnchorToCenterX.isActive = true
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on subCategory picker")
                //categorySubCategoryLabel moved to postion 2, categoryPicker moved to postion 3, subCategoryPicker moved to position 4
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                   //move the categorySubCategoryLabel to the right
                    self.categorySubCategoryLabelTrailingAnchorToCenterX.constant = 0
                    
                    
                    //moves the category to the right
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = 0
                    
                    //moves the subcategory out of the view to the right
                    self.subCategoryPickerViewLeadingAnchorToCenterX.isActive = false
                    self.subCategoryPickerViewLeadingAnchorToTrailingAnchor.isActive = true
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

