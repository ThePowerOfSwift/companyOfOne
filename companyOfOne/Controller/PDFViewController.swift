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
    var titleTagAnnotationBounds = CGRect()
    var categorySubCategoryAnnotationBounds = CGRect()
    var occurrenceAnnotationBounds = CGRect()
    var docDateAnnotationBounds = CGRect()
    var yPosition1 = CGFloat()
    var yPosition2  = CGFloat()
    var yPosition3 = CGFloat()
    var yPosition4 = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        pdfView = PDFView(frame: self.view.bounds) //does this do anything?
        view.addSubview(pdfView)
        setupPDFView()
       createSinglePDF()
       // createMultipagePDF()
        setupAnnotationLocations()
//        addAnnotations(contents: "titleTag", bounds: titleTagAnnotationBounds)
//        addAnnotations(contents: "categorySubCategory", bounds: categorySubCategoryAnnotationBounds)
//        addAnnotations(contents: "occurrence", bounds: occurrenceAnnotationBounds)
//        addAnnotations(contents: "docDate", bounds: docDateAnnotationBounds)
    }
    
    func setupAnnotationLocations(){
        commonAnnotationWidth = 800
        commonAnnotationHeight = 100
        commonAnnotationX = view.frame.width/2 //400
        yPosition1 = 1*(view.frame.height/5)
        yPosition2 = 2*(view.frame.height/5)
        yPosition3 = 3*(view.frame.height/5)
        yPosition4 = 4*(view.frame.height/5)
        //create the point for landing the annotation in view space
        let titleTagPoint = CGPoint(x: commonAnnotationX, y: yPosition1)
        let categorySubCategoryPoint = CGPoint(x: commonAnnotationX, y: yPosition2)
        let occurrencePoint = CGPoint(x: commonAnnotationX, y: yPosition3)
        let docDatePoint = CGPoint(x: commonAnnotationX, y: yPosition4)
        //convert the point from view spaceto page space
        if let page = pdfView.document?.page(at: 0){
            let convertedTitleTagPoint = pdfView.convert(titleTagPoint, to: page)
            let convertedCategorySubCategoryPoint = pdfView.convert(categorySubCategoryPoint, to: page)
            let convertedOccurrencePoint = pdfView.convert(occurrencePoint, to: page)
            let convertedDocDatePoint = pdfView.convert(docDatePoint, to: page)
            //create the annotation size
            let rectSize = CGSize(width: commonAnnotationWidth, height: commonAnnotationHeight)
            //create and place the rectangles using the converted origin and the common size
            titleTagAnnotationBounds = CGRect(origin: convertedTitleTagPoint, size: rectSize)
            categorySubCategoryAnnotationBounds = CGRect(origin: convertedCategorySubCategoryPoint, size: rectSize)
            occurrenceAnnotationBounds = CGRect(origin: convertedOccurrencePoint, size: rectSize)
            docDateAnnotationBounds = CGRect(origin: convertedDocDatePoint, size: rectSize)
        }
    }
    
    func setupPDFView(){
      //  pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      // pdfView.translatesAutoresizingMaskIntoConstraints = false
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
                let imageSize = CGSize(width: image.size.width/2, height: 100)
                let annotationLocation = CGPoint(x: image.size.width/2, y: 1*(image.size.height/5))
                let annotationLocation2 = CGPoint(x: image.size.width/2, y: 2*(image.size.height/5))
                let annotationLocation3 = CGPoint(x: image.size.width/2, y: 3*(image.size.height/5))
                let annotationLocation4 = CGPoint(x: image.size.width/2, y: 4*(image.size.height/5))
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
                addAnnotations(contents: "this is a titleTag", bounds: CGRect(origin: annotationLocation4, size: imageSize), color:#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).withAlphaComponent(0.7))
                addAnnotations(contents: "this is a category", bounds: CGRect(origin: annotationLocation3, size: imageSize), color:#colorLiteral(red: 0.1773889844, green: 1, blue: 0.1456064391, alpha: 1).withAlphaComponent(0.7))
                addAnnotations(contents: "this is a occurrence", bounds: CGRect(origin: annotationLocation2, size: imageSize), color:#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.7))
                addAnnotations(contents: "this is a docDate", bounds: CGRect(origin: annotationLocation, size: imageSize), color:#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1).withAlphaComponent(0.7))
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
                        let viewRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
                        UIGraphicsBeginPDFPageWithInfo(viewRect, nil)
                        //  let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        //UIGraphicsBeginPDFPageWithInfo(imageRect, nil)
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
            //this is where I would add the annotations
        }else{
            print("No documents found in the documents to display array")
        }
    }
        
    func addAnnotations(contents:String, bounds: CGRect, color: UIColor){
        let page = pdfView.document?.page(at: 0)
        let annotation = PDFAnnotation(bounds: bounds, forType: .widget, withProperties: nil)
        annotation.widgetFieldType = .text
        annotation.widgetStringValue = contents //this works
        annotation.shouldDisplay = true
        annotation.font = UIFont.systemFont(ofSize: 60)
        annotation.backgroundColor = color
       // annotation.backgroundColor = UIColor.red.withAlphaComponent(0.5)
       
        
        
        page?.addAnnotation(annotation)
        //TODO:- TO FIX: Find a way to make the annotation not editable
        annotation.isReadOnly = true //doesn't work
        //pdfView.document?.allowsFormFieldEntry = false //doesn't work
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

