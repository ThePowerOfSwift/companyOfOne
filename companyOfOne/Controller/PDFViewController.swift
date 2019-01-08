//
//  PDFViewController.swift
//  companyOfOne
//
//  Created by Jamie on 2019-01-03.
//  Copyright © 2019 Jamie. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var documentsToDisplay:[Document] = []
    var pdfView = PDFView()
   // var pdfDocument = PDFDocument()
    
    
    var commonAnnotationWidth = CGFloat()
    var commonAnnotationHeight = CGFloat()
    var commonAnnotationX = CGFloat()
    var titleTagAnnotationLocation = CGRect()
    var categorySubCategoryAnnotationLocation = CGRect()
    var occurrenceAnnotationLocation = CGRect()
    var docDateAnnotationLocation = CGRect()
    var firstTestLocation = CGRect()
    var secondTestLocation = CGRect()
    var thirdTestLocation = CGRect()
    var fourthTestLocation = CGRect()
    var yPosition1 = CGFloat()
    var yPosition2  = CGFloat()
    var yPosition3 = CGFloat()
    var yPosition4 = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        pdfView = PDFView(frame: self.view.bounds)
        
        
        view.addSubview(pdfView)
//        if let document = pdfView.document{
//            pdfDocument = document
//        }
        setupPDFView()
        //displayPDFFromDocument()
        
       // createSinglePDF()
        createMultipagePDF()
        setupAnnotationLocations()
        addAnnotations(contents: "titleTag", location: firstTestLocation)
        addAnnotations(contents: "categorySubCategory", location: secondTestLocation)
        addAnnotations(contents: "occurrence", location: thirdTestLocation)
        addAnnotations(contents: "docDate", location: fourthTestLocation)
    }
    
    func setupAnnotationLocations(){
        commonAnnotationWidth = 800
        commonAnnotationHeight = 100
        commonAnnotationX = 400
        yPosition1 = 1*(view.frame.height/5)
        yPosition2 = 2*(view.frame.height/5)
        yPosition3 = 3*(view.frame.height/5)
        yPosition4 = 4*(view.frame.height/5)
        let testPoint = CGPoint(x: commonAnnotationX, y: yPosition1)
        let testPoint2 = CGPoint(x: commonAnnotationX, y: yPosition2)
        let testPoint3 = CGPoint(x: commonAnnotationX, y: yPosition3)
        let testPoint4 = CGPoint(x: commonAnnotationX, y: yPosition4)
 
//        titleTagAnnotationLocation = CGRect(x: commonAnnotationX, y: yPosition1, width: commonAnnotationWidth, height: commonAnnotationHeight)
//        categorySubCategoryAnnotationLocation = CGRect(x: commonAnnotationX, y: yPosition2, width: commonAnnotationWidth, height: commonAnnotationHeight)
//        occurrenceAnnotationLocation = CGRect(x: commonAnnotationX, y: yPosition3, width: commonAnnotationWidth, height: commonAnnotationHeight)
//        docDateAnnotationLocation = CGRect(x: commonAnnotationX, y: yPosition4, width: commonAnnotationWidth, height: commonAnnotationHeight)
        //if let page = pdfView.document?.page(at: 0)
        
        if let page = pdfView.document?.page(at: 0){
            let convertedPoint = pdfView.convert(testPoint, to: page)
            let convertedPoint2 = pdfView.convert(testPoint2, to: page)
            let convertedPoint3 = pdfView.convert(testPoint3, to: page)
            let convertedPoint4 = pdfView.convert(testPoint4, to: page)
            let rectSize = CGSize(width: commonAnnotationWidth, height: commonAnnotationHeight)
            firstTestLocation = CGRect(origin: convertedPoint, size: rectSize)
            
           // firstTestLocation = pdfView.convert(titleTagAnnotationLocation, to: pdfView.page(for: testPoint, nearest: true)!)
            secondTestLocation = CGRect(origin: convertedPoint2, size: rectSize)
            thirdTestLocation = CGRect(origin: convertedPoint3, size: rectSize)
            fourthTestLocation = CGRect(origin: convertedPoint4, size: rectSize)
        }
    }
    

//    func displayPDFFromDocument(){
//        pdfView.translatesAutoresizingMaskIntoConstraints = false
//        pdfView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        //add PDFView to view
//
//        pdfView.autoScales = true
//        //TODO:- TO FIX: The PDF is way larger than a page, find a way to size it for export?
////        pdfView.maxScaleFactor = 4.0
////        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
//        //set constraints
//        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
//        //get image data (in binary)
//        if let imageData = documentsToDisplay[0].pictureData{
//            print("found picture binary data successfully")
//            //create image from image data
//            if let image = UIImage(data: imageData){
//                print("image created successfully")
//                let pdfData = NSMutableData()
//                //create UIImageView from image
//                let imgView = UIImageView.init(image: image)
//                //draw a rectangle at 0,0 and match the width and height of the image
//                let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height) //this should actually be a page rect constant for each page in the completed file, will stay with this for now
//
//                //begin create PDF
//                UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
//                UIGraphicsBeginPDFPage()  //call this for each new page
//
//                let context = UIGraphicsGetCurrentContext()
//                imgView.layer.render(in: context!)
//                UIGraphicsEndPDFContext()
//                //end create PDF
//
//                let document  = PDFDocument(data: pdfData as Data)
//                    print("created document from converted data successfully")
//                    pdfView.document = document
//            }
//        }
//    }
    
    func setupPDFView(){
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pdfView.autoScales = true
      //  TODO:- TO FIX: The PDF is way larger than a page, find a way to size it for export?
//                pdfView.maxScaleFactor = 4.0
//                pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        //set constraints
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func createSinglePDF(){
        if let imageData = documentsToDisplay[0].pictureData{
            print("found picture binary data successfully")
            //create image from image data
            if let image = UIImage(data: imageData){
                print("image created successfully")
                let pdfData = NSMutableData()
                //create UIImageView from image
                let imgView = UIImageView.init(image: image)
                //draw a rectangle at 0,0 and match the width and height of the image
                let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height) //this should actually be a page rect constant for each page in the completed file, will stay with this for now
                
                //begin create PDF
                UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
                UIGraphicsBeginPDFPage()  //call this for each new page
                
                let context = UIGraphicsGetCurrentContext()
                imgView.layer.render(in: context!)
                UIGraphicsEndPDFContext()
                //end create PDF
                
                let document  = PDFDocument(data: pdfData as Data)
                print("created document from converted data successfully")
                pdfView.document = document
            }
        }
    }
    
    func createMultipagePDF(){
        if documentsToDisplay.count != 0{
            let pdfData = NSMutableData()
            let pageRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            //create the context
            UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
            for document in documentsToDisplay{
                if let imageData = document.pictureData{
                    print("found picture binary data successfully")
                    //create image from image data
                    if let image = UIImage(data: imageData){
                        print("image created successfully from data")
                        let imgView = UIImageView.init(image: image)
                        print("imageView created successfully from image")
                        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        UIGraphicsBeginPDFPageWithInfo(imageRect, nil)
                        let context = UIGraphicsGetCurrentContext()
                        imgView.layer.render(in: context!)
                        print("imageView added to graphic context")
                    }
                }
            }
            UIGraphicsEndPDFContext() //This function closes the last page and writes the PDF content to the file or data object
            let document  = PDFDocument(data: pdfData as Data)
            print("created multipage document from converted data successfully")
            pdfView.document = document
        }else{
            print("No documents found in the documents to display array")
        }
    }
        
    func addAnnotations(contents:String, location: CGRect){
        let page = pdfView.document?.page(at: 0)
        let annotation = PDFAnnotation(bounds: location, forType: .widget, withProperties: nil)
        annotation.widgetFieldType = .text
        annotation.widgetStringValue = contents //this works
        annotation.shouldDisplay = true
        annotation.font = UIFont.systemFont(ofSize: 60)
        annotation.backgroundColor = UIColor.lightGray
        page?.addAnnotation(annotation)
        //TODO:- TO FIX: Find a way to make the annotation not editable
        //annotation.isReadOnly = true //doesn't work
        //pdfView.document?.allowsFormFieldEntry = false
        //pdfView.endEditing(true) //doesn't work
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        if let document = self.pdfView.document{
            guard let data = document.dataRepresentation() else { return }
            let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareButtonPressedTest(_ sender: UIButton) {
        print("It worked")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Ok maybe I can do a loop that pulls out tag/title, category/subCategory, date and builds the image.  Then in that loop I need to build the single (or multipage) PDF and view it.


//-------------------------------------------------

// UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 50, height: 50), nil)
//                let font = UIFont.systemFont(ofSize: 14.0)
//
//                let textRect = CGRect(x: 5, y: 3, width: 125, height: 18)
//                let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//                paragraphStyle.alignment = NSTextAlignment.left
//                paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
//
//                let textColor = UIColor.black
//
//                let textFontAttributes = [
//                    NSAttributedString.Key.font: font,
//                    NSAttributedString.Key.foregroundColor: textColor,
//                    NSAttributedString.Key.paragraphStyle: paragraphStyle
//                ]
//
//                let text:NSString = "Hello world"
//
//                text.draw(in: textRect, withAttributes: textFontAttributes)

//------------------------------------

