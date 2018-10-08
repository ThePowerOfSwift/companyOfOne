//
//  EditViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit


class EditViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var titleTagTextField: UITextField!
    @IBOutlet weak var categorySubCategoryLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var subCategoryPickerView: UIPickerView!
    @IBOutlet weak var occuranceLabel: UILabel!
    @IBOutlet weak var occurancePickerView: UIPickerView!
    @IBOutlet weak var docDateLabel: UILabel!
    @IBOutlet weak var DocDatePickerView: UIDatePicker!
    
    //MARK: Global Constants
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
    var labelAlpha = CGFloat()
    
    //MARK: Global Constraints
    var titleTagLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var titleTagTextFieldLeadingAnchorToCenterX = NSLayoutConstraint()
    var categorySubCategoryLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var categoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var subCategoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var occuranceLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var occurancePickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var docDateLabelViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var docDatePickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        self.titleTagTextField.delegate = self
        //constants
        setupX_Y_W_H_Alpha_Constants()
        //labels
        setupDocTitleTagLabel()
        setupDocTitleTagTextField()
        setupCategorySubCategoryLabel()
        setupOccuranceLabel()
        setupDocDateLabel()
        //pickers
        setupCategoryPicker()
        setupSubCategoryPicker()
        setupOccurancePicker()
        setupDocDatePicker()
        //swipes
        addSwipeGuesturesForDocTitle()
        addSwipeGuesturesForCategory()
        addSwipeGuesturesForSubCategory()
        addSwipeGuesturesForOccurance()
        addSwipeGuesturesForDocDate()
        
    }
    
    @IBAction func changedTitleTagText(_ sender: Any) {
        titleTagLabel.text = titleTagTextField.text ?? "Title / Tag"
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTagTextField.resignFirstResponder()
        return true
    }
    
    func setupX_Y_W_H_Alpha_Constants(){
        //X
        xPosition1 = -1*(view.frame.width)
        xPosition2 = -1*(view.frame.width/2)
        xPosition3 = 0
        xPosition4 = view.frame.width/2
        xPosition5 = view.frame.width
        //Y
        yPosition1 = 1*(view.frame.height/5)
        yPosition2 = 2*(view.frame.height/5)
        yPosition3 = 3*(view.frame.height/5)
        yPosition4 = 4*(view.frame.height/5)
        //W
        allWidthConstant = view.frame.width/2
        //H
        labelHeightConstant = 30
        pickerHeightConstant = view.frame.height/5
        //Alpha
        labelAlpha = 0.6
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
    
    func addSwipeGuesturesForCategory(){
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
    
    func addSwipeGuesturesForOccurance(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccuranceLabelShowsAndHidesOccurancePicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccuranceLabelShowsAndHidesOccurancePicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        occuranceLabel.addGestureRecognizer(leftSwipe)
        occurancePickerView.addGestureRecognizer(rightSwipe)
    }
    
    func addSwipeGuesturesForDocDate(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocDateLabelShowsAndHidesDocDatePicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocDateLabelShowsAndHidesDocDatePicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        docDateLabel.addGestureRecognizer(leftSwipe)
        DocDatePickerView.addGestureRecognizer(rightSwipe)
    }
    
    //MARK: Setup Title and Constraints
    
    func setupDocTitleTagLabel(){
        //setup the look
        titleTagLabel.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        titleTagLabel.alpha = labelAlpha
        titleTagLabel.text = titleTagTextField.text ?? "Title / Tag"
        titleTagLabel.text = "Title / Tag"
        //setup in xPosition 3, yPositon 1
        titleTagLabel.isUserInteractionEnabled = true
        titleTagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTagLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        titleTagLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        titleTagLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition1).isActive = true
        
        //this the global constraint to be animated
        titleTagLabelLeadingAnchorToCenterX = titleTagLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        titleTagLabelLeadingAnchorToCenterX.isActive = true
    }
    
    func setupDocTitleTagTextField(){
        //setup the look
        titleTagTextField.returnKeyType = .done
        titleTagTextField.layer.borderWidth = 1
        titleTagTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 1
        titleTagTextField.isUserInteractionEnabled = true
        titleTagTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTagTextField.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        titleTagTextField.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        titleTagTextField.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition1).isActive = true
        //this is the global constraint to be animated
        titleTagTextFieldLeadingAnchorToCenterX = titleTagTextField.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        titleTagTextFieldLeadingAnchorToCenterX.isActive = true
    }
    
    //MARK: Setup Categories and Constraints
    
    func setupCategorySubCategoryLabel(){
        //setup the look
        categorySubCategoryLabel.backgroundColor = #colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1)
        categorySubCategoryLabel.alpha = labelAlpha
        categorySubCategoryLabel.text = "Category : SubCategory"
        //setup in xPosition 3, yPosition 2
        categorySubCategoryLabel.isUserInteractionEnabled = true
        categorySubCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categorySubCategoryLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        categorySubCategoryLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        categorySubCategoryLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition2).isActive = true
        //this the global constraint to be animated
        categorySubCategoryLabelLeadingAnchorToCenterX = categorySubCategoryLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        categorySubCategoryLabelLeadingAnchorToCenterX.isActive = true
    }
    
    func setupCategoryPicker(){
        //setup the look
        categoryPickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        categoryPickerView.layer.cornerRadius = 10
        categoryPickerView.layer.borderWidth = 1
        categoryPickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 2
        categoryPickerView.isUserInteractionEnabled = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerView.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        categoryPickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        categoryPickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition2).isActive = true
        //this is the global constraint to be animated
        categoryPickerViewLeadingAnchorToCenterX = categoryPickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        categoryPickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    func setupSubCategoryPicker(){
        //setup the look
        subCategoryPickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subCategoryPickerView.layer.cornerRadius = 10
        subCategoryPickerView.layer.borderWidth = 1
        subCategoryPickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 5, yPosition 2
        subCategoryPickerView.isUserInteractionEnabled = true
        subCategoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        subCategoryPickerView.widthAnchor.constraint(equalToConstant:allWidthConstant).isActive = true
        subCategoryPickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        subCategoryPickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition2).isActive = true
        //this is the global constraint to be animatedw
        subCategoryPickerViewLeadingAnchorToCenterX = subCategoryPickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition5)
        subCategoryPickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    //MARK: Setup Occurance and Constraints
    
    func setupOccuranceLabel(){
        //setup the look
        occuranceLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        occuranceLabel.alpha = labelAlpha
        occuranceLabel.text = "Occurance"
        //setup in xPosition 3, yPosition 3
        occuranceLabel.isUserInteractionEnabled = true
        occuranceLabel.translatesAutoresizingMaskIntoConstraints = false
        occuranceLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        occuranceLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        occuranceLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition3).isActive = true
        //this the global constraints to be animated
        occuranceLabelLeadingAnchorToCenterX = occuranceLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        occuranceLabelLeadingAnchorToCenterX.isActive = true
    }
    
    func setupOccurancePicker(){
        //setup the look
        occurancePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        occurancePickerView.layer.cornerRadius = 10
        occurancePickerView.layer.borderWidth = 1
        occurancePickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 3
        occurancePickerView.isUserInteractionEnabled = true
        occurancePickerView.translatesAutoresizingMaskIntoConstraints = false
        occurancePickerView.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        occurancePickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        occurancePickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition3).isActive = true
        //this is the global constraints to be animated
        
        occurancePickerViewLeadingAnchorToCenterX = occurancePickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        occurancePickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    //MARK: Setup DocDate and Constraints
    
    func setupDocDateLabel(){
        //setup the look
        docDateLabel.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        docDateLabel.alpha = labelAlpha
        docDateLabel.text = "Document Date"
        //setup in xPosition 3, yPosition 4
        docDateLabel.isUserInteractionEnabled = true
        docDateLabel.translatesAutoresizingMaskIntoConstraints = false
        docDateLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        docDateLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        docDateLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition4).isActive = true
        //this the global constraints to be animated
        docDateLabelViewLeadingAnchorToCenterX = docDateLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        docDateLabelViewLeadingAnchorToCenterX.isActive = true
    }
    
    func setupDocDatePicker(){
        //setup the look
        DocDatePickerView.datePickerMode = .date
        DocDatePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        DocDatePickerView.layer.masksToBounds = true
        DocDatePickerView.layer.cornerRadius = 10
        DocDatePickerView.layer.borderWidth = 1
        DocDatePickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 4
        DocDatePickerView.isUserInteractionEnabled = true
        DocDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        DocDatePickerView.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        DocDatePickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        DocDatePickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition4).isActive = true
        //this is the global constraints to be animated
        docDatePickerViewLeadingAnchorToCenterX = DocDatePickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        docDatePickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    //MARK: All Swipe Functions
    
    @objc func swipeOnDocTitleTagShowsAndHidesTitleTagTextField(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on titleTag label")
                //titleTagLabel moved to postion 2, titleTagTextInput moved to position 3
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.titleTagLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.titleTagTextFieldLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on titleTag text input")
                //titleTagLabel moved to postion 3, titleTagTextInput moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
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
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.subCategoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on category picker")
                //categoryLabel moved to postion 3, categoryPicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.constant = self.xPosition3
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.subCategoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition5
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
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.constant = self.xPosition1
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition2
                    self.subCategoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on subCategory picker")
                //categorySubCategoryLabel moved to postion 2, categoryPicker moved to postion 3, subCategoryPicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.categorySubCategoryLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.categoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.subCategoryPickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func swipeOnOccuranceLabelShowsAndHidesOccurancePicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on occurance label")
                //occuranceLabel moved to postion 2, occurnacePicker moved to position 3
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occuranceLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.occurancePickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on occurance picker")
                //occuranceLabel moved to postion 3, occurancePicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occuranceLabelLeadingAnchorToCenterX.constant = self.xPosition3
                    self.occurancePickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func swipeOnDocDateLabelShowsAndHidesDocDatePicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on docDate label")
                //docDateLabel moved to postion 2, docDatePicker moved to position 3
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.docDateLabelViewLeadingAnchorToCenterX.constant = self.xPosition2
                    self.docDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on docDate picker")
                //docDateLabel moved to postion 3, docDatePicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.docDateLabelViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.docDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
}

