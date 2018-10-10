//
//  EditViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit


class EditViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var titleTagTextField: UITextField!
    @IBOutlet weak var categorySubCategoryLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var subCategoryPickerView: UIPickerView!
    @IBOutlet weak var occurrenceLabel: UILabel!
    @IBOutlet weak var occurrencePickerView: UIPickerView!
    @IBOutlet weak var occurrenceDatePickerView: UIPickerView!
    @IBOutlet weak var docDateLabel: UILabel!
    @IBOutlet weak var docDatePickerView: CustomDatePicker!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var docImageView: UIImageView!
    
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
    
    //MARK: Global Arrays
    var allCategoriesSubCategories = [Category]()
    var categories = [String]()
    var subCategories = [String]()
    var occurrences = [String]()
    var categorySubCategoryLabels = [String]()
   // var testcategorySubCategoryLabels = [Any]()
    var occurrenceLabels = [String]()
    
    //MARK: Global Constraints
    var titleTagLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var titleTagTextFieldLeadingAnchorToCenterX = NSLayoutConstraint()
    var categorySubCategoryLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var categoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var subCategoryPickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var occurrenceLabelLeadingAnchorToCenterX = NSLayoutConstraint()
    var occurrencePickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var occurrenceDatePickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var docDateLabelViewLeadingAnchorToCenterX = NSLayoutConstraint()
    var docDatePickerViewLeadingAnchorToCenterX = NSLayoutConstraint()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        titleTagTextField.delegate = self
        categoryPickerView.delegate = self
        subCategoryPickerView.delegate = self
        occurrencePickerView.delegate = self //fix this spelling
        //data
        setupTempDataForTesting()
        //constants
        setupX_Y_W_H_Alpha_Constants()
        //labels
        setupDocTitleTagLabel()
        setupDocTitleTagTextField()
        setupCategorySubCategoryLabel()
        setupOccurrenceLabel()
        setupDocDateLabel()
        //pickers
        setupCategoryPicker()
        setupSubCategoryPicker()
        setupOccurrencePicker()
        setupOccurrenceDatePicker()
        setupDocDatePicker()
        //buttons
        setupTrashAndSubmitButtons()
        //gestures
        addTapGestureForHideNavBar_Labels_AndButtons()
        addSwipeGuesturesForDocTitle()
        addSwipeGuesturesForCategory()
        addSwipeGuesturesForSubCategory()
        addSwipeGuesturesForOccurrence()
        addSwipeGuesturesForOccurrenceDate()
        addSwipeGuesturesForDocDate()
    }
    
    //MARK: Temp Testing Data
    
    func createUserCategory(name:String) -> Category{
        let userCategory = Category(name: "\(name)")
        allCategoriesSubCategories.append(userCategory)
        return userCategory
        //add to the tableView that displays the categories
    }
    
    func createUserSubCategory(category: Category, name: String) -> SubCategory{
        let userSubCategory = SubCategory(name: name)
        category.subCategories.append(userSubCategory)
        return userSubCategory
        //add to the tableView that displays the subCategories
    }
    
    func setupTempDataForTesting(){
    
//        let newCategory = createUserCategory(name: "Rental")
//        let newSubCategory = createUserSubCategory(category: newCategory, name: "Income")
        
        
        //populate array for category
        categories = ["To Be Categorized",
                      "Rental Property",
                      "Capital Gains",
                      "RRSPs","Dividends",
                      "Medical",
                      "Other Income",
                      "Previous Assessments",
                      "Tax Payments" ]
        //populate array for subCategory
        subCategories = ["-",
                      "Income",
                      "Expenses",
                      "Operating Costs",
                      "Renovation Expenses",
                      "Special Assessments",
                      "Realtor Fees",
                      "Previous Assessments",
                      "Purchase Documents" ]
        //populate array for occurrence
        occurrences = ["None",
                       "Biweekly",
                       "Monthly",
                       "Yearly"]
        //populate array for occurrence dates
        
        //populate arrays for labels
        categorySubCategoryLabels = [("\(categories[0])"),
                            ("\(subCategories[0])")]
        occurrenceLabels = [("\(occurrences[0])"),
                            "-"]
        print(occurrenceLabels)
    }
    
    //MARK: Title/Tag Delegate Functions
    
    @IBAction func changedTitleTagText(_ sender: Any) {
        titleTagLabel.text = titleTagTextField.text ?? "Title / Tag"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("hit return after titleTag text input")
        //        DispatchQueue.main.async {[unowned self] in     //do I need this?
        //        }
        moveTitleTagLabelAndTitleTagTextFieldToxPosition3And4()
        return true
    }
    
    
    //MARK: PickerView Delegate Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if categoryPickerView == pickerView {
            return 1
        }
        if subCategoryPickerView == pickerView {
            return 1
        }
        if occurrencePickerView == pickerView {
            return 1
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if categoryPickerView == pickerView {
            return categories.count
        }
        if subCategoryPickerView == pickerView {
            return 5 //subCategories.count
        }
        if occurrencePickerView == pickerView {
            return occurrences.count
        }
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if categoryPickerView == pickerView {
            return categories[row]
        }
        if subCategoryPickerView == pickerView {
            return subCategories[row]
        }
        if occurrencePickerView == pickerView {
            return occurrences[row]
        }
        return "--"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if categoryPickerView == pickerView {
            let category = categories[pickerView.selectedRow(inComponent: 0)]
            //categorySubCategoryLabels[0] = category.name
            //testcategorySubCategoryLabels[0] = category
            //categories[pickerView.selectedRow(inComponent: 0)]
            categorySubCategoryLabels[0] = category
            categorySubCategoryLabel.text = categorySubCategoryLabels.joined(separator: ": ")
        }
        if subCategoryPickerView == pickerView {
//            let category = allCategoriesSubCategories[0]//I have to have a reference to a specific category to get access to the subCategory array
//            let subCategory = category.subCategories[pickerView.selectedRow(inComponent: 0)]
//            categorySubCategoryLabels[1] = subCategory.name
            let subCategory = subCategories[pickerView.selectedRow(inComponent: 0)]
            categorySubCategoryLabels[1] = subCategory
            categorySubCategoryLabel.text = (categorySubCategoryLabels.joined(separator: ": "))
        }
        if occurrencePickerView == pickerView {
            let occurrence = occurrences[pickerView.selectedRow(inComponent: 0)]
            occurrenceLabels[0] = occurrence
            occurrenceLabel.text = (occurrenceLabels.joined(separator: ": "))
        }
        if occurrenceDatePickerView == pickerView {
            print(occurrenceLabels)
            let occurrenceMonth = occurrences[pickerView.selectedRow(inComponent: 0)]
            let occurrenceYear = occurrences[pickerView.selectedRow(inComponent: 1)]
            let occurenceDate = "\(occurrenceMonth), \(occurrenceYear)"
            occurrenceLabels.insert(occurenceDate, at: 1) //last position
            occurrenceLabel.text = (occurrenceLabels.joined(separator: ": "))
        }
        
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
    }
    
    //MARK: Setup Constants
    
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
    
    func addTapGestureForHideNavBar_Labels_AndButtons(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.tapToShow_HideEverything(_:)))
        imageTap.numberOfTapsRequired = 1
        imageTap.numberOfTouchesRequired = 1
        docImageView.addGestureRecognizer(imageTap)
    }
    
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
    
    func addSwipeGuesturesForOccurrence(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccurrenceLabelShowsAndHidesOccurrencePicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccurrenceLabelShowsAndHidesOccurrencePicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        occurrenceLabel.addGestureRecognizer(leftSwipe)
        occurrencePickerView.addGestureRecognizer(rightSwipe)
    }
    
    func addSwipeGuesturesForOccurrenceDate(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccurrencePickerShowsAndHidesOccurrenceDatePicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnOccurrencePickerShowsAndHidesOccurrenceDatePicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        occurrencePickerView.addGestureRecognizer(leftSwipe)
        occurrenceDatePickerView.addGestureRecognizer(rightSwipe)
    }
    
    func addSwipeGuesturesForDocDate(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocDateLabelShowsAndHidesDocDatePicker(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeOnDocDateLabelShowsAndHidesDocDatePicker(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        docDateLabel.addGestureRecognizer(leftSwipe)
        docDatePickerView.addGestureRecognizer(rightSwipe) //fix this spellingocc
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
        titleTagTextField.layer.cornerRadius = 5
        titleTagTextField.layer.masksToBounds = true
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
        categorySubCategoryLabel.text = (categorySubCategoryLabels.joined(separator: ": "))
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
    
    //MARK: Setup Occurrence and Constraints
    
    func setupOccurrenceLabel(){
        //setup the look
        occurrenceLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        occurrenceLabel.alpha = labelAlpha
        occurrenceLabel.text = (occurrenceLabels.joined(separator: ": "))
        //setup in xPosition 3, yPosition 3
        occurrenceLabel.isUserInteractionEnabled = true
        occurrenceLabel.translatesAutoresizingMaskIntoConstraints = false
        occurrenceLabel.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        occurrenceLabel.heightAnchor.constraint(equalToConstant: labelHeightConstant).isActive = true
        occurrenceLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition3).isActive = true
        //this the global constraints to be animated
        occurrenceLabelLeadingAnchorToCenterX = occurrenceLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition3)
        occurrenceLabelLeadingAnchorToCenterX.isActive = true
    }
    
    func setupOccurrencePicker(){
        //setup the look
        occurrencePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        occurrencePickerView.layer.cornerRadius = 10
        occurrencePickerView.layer.borderWidth = 1
        occurrencePickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 3
        occurrencePickerView.isUserInteractionEnabled = true
        occurrencePickerView.translatesAutoresizingMaskIntoConstraints = false
        occurrencePickerView.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        occurrencePickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        occurrencePickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition3).isActive = true
        //this is the global constraints to be animated
        
        occurrencePickerViewLeadingAnchorToCenterX = occurrencePickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        occurrencePickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    func setupOccurrenceDatePicker(){
        //setup the look
        occurrenceDatePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        occurrenceDatePickerView.layer.cornerRadius = 10
        occurrenceDatePickerView.layer.borderWidth = 1
        occurrenceDatePickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 5, yPosition 3
        occurrenceDatePickerView.isUserInteractionEnabled = true
        occurrenceDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        occurrenceDatePickerView.widthAnchor.constraint(equalToConstant:allWidthConstant).isActive = true
        occurrenceDatePickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        occurrenceDatePickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition3).isActive = true
        //this is the global constraint to be animated
        occurrenceDatePickerViewLeadingAnchorToCenterX = occurrenceDatePickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition5)
        occurrenceDatePickerViewLeadingAnchorToCenterX.isActive = true
        //setup the date data
      
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
        docDatePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        docDatePickerView.layer.masksToBounds = true
        docDatePickerView.layer.cornerRadius = 10
        docDatePickerView.layer.borderWidth = 1
        docDatePickerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //setup in xPosition 4, yPosition 4
        docDatePickerView.isUserInteractionEnabled = true
        docDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        docDatePickerView.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        docDatePickerView.heightAnchor.constraint(equalToConstant: pickerHeightConstant).isActive = true
        docDatePickerView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: yPosition4).isActive = true
        //this is the global constraints to be animated
        docDatePickerViewLeadingAnchorToCenterX = docDatePickerView.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xPosition4)
        docDatePickerViewLeadingAnchorToCenterX.isActive = true
    }
    
    func setupTrashAndSubmitButtons(){
        //setup the trash button look
        trashButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        trashButton.layer.borderWidth = 0.2
        trashButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //trashButton.alpha = labelAlpha
        trashButton.titleLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        trashButton.layer.masksToBounds = true
        //trashButton.layer.cornerRadius = 10
        trashButton.titleLabel?.text = "Trash"
        //setup the constraints
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        trashButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        trashButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        trashButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        //setup the submit button look
        submitButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        submitButton.layer.borderWidth = 0.2
        submitButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //submitButton.alpha = labelAlpha
        submitButton.titleLabel?.textColor = #colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1)
        submitButton.layer.masksToBounds = true
        //submitButton.layer.cornerRadius = 10
        submitButton.titleLabel?.text = "Submit"
        //setup the constraints
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.widthAnchor.constraint(equalToConstant: allWidthConstant).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    //MARK: All GestureRecognizer Functions
    
    @objc func tapToShow_HideEverything(_ sender:UITapGestureRecognizer){
        print("tapped on the docImage")
        //hide nav
        navigationController!.isNavigationBarHidden = !navigationController!.isNavigationBarHidden
        //hide all labels
        titleTagLabel.isHidden = !titleTagLabel.isHidden
        categorySubCategoryLabel.isHidden = !categorySubCategoryLabel.isHidden
        occurrenceLabel.isHidden = !occurrenceLabel.isHidden
        docDateLabel.isHidden = !docDateLabel.isHidden
        //hide all buttons
        trashButton.isHidden = !trashButton.isHidden
        submitButton.isHidden = !submitButton.isHidden
    }
    
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
                self.moveTitleTagLabelAndTitleTagTextFieldToxPosition3And4()
            }
        }
    }
    
    func moveTitleTagLabelAndTitleTagTextFieldToxPosition3And4(){
        //titleTagLabel moved to postion 3, titleTagTextInput moved to position 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            self.titleTagLabelLeadingAnchorToCenterX.constant = self.xPosition3
            self.titleTagTextFieldLeadingAnchorToCenterX.constant = self.xPosition4
            self.view.layoutIfNeeded()
        })
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
    
    @objc func swipeOnOccurrenceLabelShowsAndHidesOccurrencePicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left on occurrence label")
                //occurrenceLabel moved to postion 2, occurrencePicker moved to position 3
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occurrenceLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.occurrencePickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.occurrenceDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on occurrence picker")
                //occurrenceLabel moved to postion 3, occurrencePicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occurrenceLabelLeadingAnchorToCenterX.constant = self.xPosition3
                    self.occurrencePickerViewLeadingAnchorToCenterX.constant = self.xPosition4
                    self.occurrenceDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition5
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func swipeOnOccurrencePickerShowsAndHidesOccurrenceDatePicker(_ sender:UISwipeGestureRecognizer){
        DispatchQueue.main.async {[unowned self] in
            
            if (sender.direction == .left) {
                print("swiped left occurrence picker")
                //occurrenceLabel moved to postion 1, occurrencePicker moved to postion 2, occurrenceDatePicker moved to position 3
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occurrenceLabelLeadingAnchorToCenterX.constant = self.xPosition1
                    self.occurrencePickerViewLeadingAnchorToCenterX.constant = self.xPosition2
                    self.occurrenceDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.view.layoutIfNeeded()
                })
            }
            if (sender.direction == .right) {
                print("swiped right on occurrence date picker")
                //categorySubCategoryLabel moved to postion 2, categoryPicker moved to postion 3, subCategoryPicker moved to position 4
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
                    self.occurrenceLabelLeadingAnchorToCenterX.constant = self.xPosition2
                    self.occurrencePickerViewLeadingAnchorToCenterX.constant = self.xPosition3
                    self.occurrenceDatePickerViewLeadingAnchorToCenterX.constant = self.xPosition4
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

