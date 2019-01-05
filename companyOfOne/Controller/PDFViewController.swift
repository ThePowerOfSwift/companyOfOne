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
    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        print(documentsToDisplay.count)
       displayPDFFromDocument()
        addAnnotations()

        
//        let newPDF = createPDFFileAndReturnPath()
//        print(newPDF)

        // Do any additional setup after loading the view.
    }

    func displayPDFFromDocument(){
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        //add PDFView to view
        view.addSubview(pdfView)
        pdfView.autoScales = true
        //set constraints
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //get image data (in binary)
        if let imageData = documentsToDisplay[0].pictureData{
            print("found picture binary data successfully")
            //create image from image data
            if let image = UIImage(data: imageData){
                print("image created successfully")
                let pdfData = NSMutableData()
                //create UIImageView from image
                let imgView = UIImageView.init(image: image)
                //draw a rectangle at 0,0 and match the width and height of the image
                let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                
                //begin create PDF
                UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
                UIGraphicsBeginPDFPage()
        
                
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
        
        func addAnnotations(){
            let page = pdfView.document?.page(at: 0)
            //let text = PDFAnnotationSubtype.text
            let annotation = PDFAnnotation(bounds: CGRect(x: 0, y:50, width: 1500, height: 100), forType: .freeText, withProperties: nil)
            annotation.shouldDisplay = true
            //annotation.font?.withSize(50) //doesn't work
            annotation.contents = "Test of contents"
            //annotation.font?.withSize(50)   //doesn't work
            page?.addAnnotation(annotation)
      
            print("\(annotation.contents ?? "contents of text annotation not found")")
            
            
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

