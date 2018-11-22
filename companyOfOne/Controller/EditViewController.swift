//
//  EditViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2018-10-07.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData
import PDFKit


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
    @IBOutlet weak var docDatePickerView: UIDatePicker!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var editViewModeButton: UIBarButtonItem!
    
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
    var categorySubCategoryLabels = [String]()
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
    
    //MARK: Current Instance Variables
    
    var currentImage = UIImage()
    var currentTitleTag = String()
    var currentDate:Date?
    
    //MARK: ViewController Booleans
    
    var fromDocsViewController:Bool = false
    var isInEditMode:Bool = true
    
    //MARK: Custom Class Instance Variables
    
    var document = Document()
    var category = Category()
    var subCategory = SubCategory()
    var occurrence = Occurrence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.isNavigationBarHidden = false
        //delegates
        titleTagTextField.delegate = self
        categoryPickerView.delegate = self
        subCategoryPickerView.delegate = self
        occurrencePickerView.delegate = self
        //data
        category.retrieveAllCategories()
        setupData()
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
        //gestures
        addTapGestureForHideNavBar_Labels_AndButtons()
        addSwipeGuesturesForDocTitle()
        addSwipeGuesturesForCategory()
        addSwipeGuesturesForSubCategory()
        addSwipeGuesturesForOccurrence()
        addSwipeGuesturesForOccurrenceDate()
        addSwipeGuesturesForDocDate()
    }
    
    //MARK: Save Document Action
    
    @IBAction func pressSaveToPDFButton(_ sender: UIBarButtonItem) {
        if isInEditMode == true {
//                    document.createDocument(titleTag: titleTagLabel.text, currentCategory: category.currentCategory, currentSubCategory: subCategory.currentSubCategory, currentOccurrence: occurrence.currentOccurrence, currentDate: currentDate)
            editViewModeButton.title = "Edit"
            self.title = "View Details"
             isInEditMode = !isInEditMode
        }else{
           
            self.title = "Add Details"
            editViewModeButton.image = #imageLiteral(resourceName: "save")
             isInEditMode = !isInEditMode
        }
        

        //self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Temp Testing Data
    
    func setupData(){
        
        docImageView.contentMode = .scaleAspectFit
        docImageView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        docImageView.image = currentImage
        
        //        populate initial labels
        if fromDocsViewController == false {
            editViewModeButton.image = #imageLiteral(resourceName: "save")
            self.title = "Add Details"
            categorySubCategoryLabels = ["Category", "SubCategory"]
            titleTagLabel.text = "Title / Tag"
            docDateLabel.text = "Document Date"
            occurrenceLabels = ["Occurrence", "-"]
            
        }else{
            editViewModeButton.title = "Edit"
            self.title = "View Details"
            categorySubCategoryLabel.text = categorySubCategoryLabels.joined(separator: ": ")
            titleTagLabel.text = currentTitleTag
            docDateLabel.text = currentDate?.format()
            //self.isInEditMode = false
        }
    }
    
    //MARK: Title/Tag Delegate Functions
    
    @IBAction func changedTitleTagText(_ sender: Any) {
        titleTagLabel.text = titleTagTextField.text ?? "Title / Tag"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("hit return after titleTag text input")
        moveTitleTagLabelAndTitleTagTextFieldToxPosition3And4()
        return true
    }
    
    //MARK: DatePicker Delegate Functions
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let documentDate = docDatePickerView.date
        currentDate = documentDate
        docDateLabel.text = documentDate.format()
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
            return ArrayHandler.sharedInstance.categoryArray.count
        }
        if subCategoryPickerView == pickerView {
            return category.currentCategory?.child?.count ?? 1
            
        }
        if occurrencePickerView == pickerView {
            return occurrence.occurrences.count
        }
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if categoryPickerView == pickerView {
            return ArrayHandler.sharedInstance.categoryArray[row].name
        }
        if subCategoryPickerView == pickerView {
            let subSet = category.currentCategory?.child
            let subArray = subSet?.allObjects as! [SubCategory]
            return subArray[row].name
        }
        if occurrencePickerView == pickerView {
            return occurrence.occurrences[row]
        }
        return "--"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if categoryPickerView == pickerView {
            let category = ArrayHandler.sharedInstance.categoryArray[pickerView.selectedRow(inComponent: 0)]
            self.category.currentCategory = category
            subCategoryPickerView.reloadAllComponents()
            let subSet =  self.category.currentCategory?.child
            let subArray = subSet?.allObjects as! [SubCategory]
            subCategory.currentSubCategory = subArray[0]
            categorySubCategoryLabels[0] =  self.category.currentCategory?.name! ?? "No Name in current category"
            categorySubCategoryLabels[1] = subArray[0].name ?? "No name in subCategory"
            categorySubCategoryLabel.text = categorySubCategoryLabels.joined(separator: ": ")
        }
        if subCategoryPickerView == pickerView {
            let subSet = category.currentCategory?.child
            let subArray = subSet?.allObjects as! [SubCategory]
            subCategory.currentSubCategory = subArray[pickerView.selectedRow(inComponent: 0)]
            
            categorySubCategoryLabels[1] = subCategory.currentSubCategory!.name ?? "SubLabel Didn't Work"
            categorySubCategoryLabel.text = (categorySubCategoryLabels.joined(separator: ": "))
        }
        if occurrencePickerView == pickerView {
            let occurrence = self.occurrence.occurrences[pickerView.selectedRow(inComponent: 0)]
            // self.occurrence.currentOccurrence = occurrence
            occurrenceLabels[0] = occurrence
            occurrenceLabel.text = (occurrenceLabels.joined(separator: ": "))
        }
        if occurrenceDatePickerView == pickerView {
            print(occurrenceLabels)
            let occurrenceMonth = occurrence.occurrences[pickerView.selectedRow(inComponent: 0)]
            let occurrenceYear = occurrence.occurrences[pickerView.selectedRow(inComponent: 1)]
            let occurenceDate = "\(occurrenceMonth), \(occurrenceYear)"
            occurrenceLabels.insert(occurenceDate, at: 1) //last position
            occurrenceLabel.text = (occurrenceLabels.joined(separator: ": "))
        }
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
        //docDateLabel.text = "Document Date"
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
    
    //MARK: All GestureRecognizer Functions
    
    @objc func tapToShow_HideEverything(_ sender:UITapGestureRecognizer){
        print("tapped on the docImage")
        //hide nav
        navigationController!.isNavigationBarHidden = !navigationController!.isNavigationBarHidden
        tabBarController!.tabBar.isHidden = !tabBarController!.tabBar.isHidden
        //hide all labels
        titleTagLabel.isHidden = !titleTagLabel.isHidden
        categorySubCategoryLabel.isHidden = !categorySubCategoryLabel.isHidden
        occurrenceLabel.isHidden = !occurrenceLabel.isHidden
        docDateLabel.isHidden = !docDateLabel.isHidden
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

