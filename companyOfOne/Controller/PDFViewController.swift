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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        print(documentsToDisplay.count)
       displayPDFFromDocument()
//        let newPDF = createPDFFileAndReturnPath()
//        print(newPDF)

        // Do any additional setup after loading the view.
    }
    func createPDFFromSelected(){
        //        guard let image = UIImage(named: "testDoc") else { return }
        //        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
        //            if completed {
        //                print("completed")
        //            } else {
        //                print("cancelled")
        //            }
        //        }
        //        present(activityController, animated: true) {
        //            print("presented")
        //
    }
    
    func createPDFDataFromImage(image: UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = "\(documentsPath)/myCoolPDF.pdf"
        pdfData.write(toFile: filePath, atomically: true)
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        
        return pdfData
    }
    
    func createPDFDataFromImage2(image: UIImage) -> NSMutableData {
        let pdfData = NSMutableData()
        let imgView = UIImageView.init(image: image)
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imgView.layer.render(in: context!)
        UIGraphicsEndPDFContext()
        
        //try saving in doc dir to confirm:
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL:URL = documentsURL.appendingPathComponent("note.pdf")
        
        do {
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        
        UIGraphicsBeginPDFContextToFile(fileURL.appendingPathComponent("note.pdf").path, CGRect.zero, nil);

        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        
        return pdfData
    }
    
    func displayPDFFromDocument(){ //this works loading a PDF from the bundle, doesn't work loading PDF from the picture data
        let pdfView = PDFView()
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
               // UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 50, height: 50), nil)
                
                
                let font = UIFont.systemFont(ofSize: 14.0)
                
                let textRect = CGRect(x: 5, y: 3, width: 125, height: 18)
                let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                paragraphStyle.alignment = NSTextAlignment.left
                paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
                
                let textColor = UIColor.black
                
                let textFontAttributes = [
                    NSAttributedString.Key.font: font,
                    NSAttributedString.Key.foregroundColor: textColor,
                    NSAttributedString.Key.paragraphStyle: paragraphStyle
                ]
                
                let text:NSString = "Hello world"
                
                text.draw(in: textRect, withAttributes: textFontAttributes)
                
                
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
    
    func viewAllPDF(){
        let pdfView = PDFView()
//        for document in documentsToDisplay{
        let document = documentsToDisplay[0]
            if let imageData = document.pictureData{
                print("imageData created successfully")
                if let image = UIImage(data: imageData){
                    print("image created successfully")
                    
                     let PDFData = createPDFDataFromImage2(image: image)
                    pdfView.document = PDFDocument(data: PDFData as Data)
            }
        }
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        self.view.addSubview(pdfView)
    }
    
    func createPDFFileAndReturnPath() -> String {
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let pathForPDF = documentsDirectory.appending("/" + fileName)
        
        UIGraphicsBeginPDFContextToFile(pathForPDF, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 100, height: 400), nil)
        //let font = UIFont(name: "System", size: 14.0)
        let font = UIFont.systemFont(ofSize: 14.0)
        
        let textRect = CGRect(x: 5, y: 3, width: 125, height: 18)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let textColor = UIColor.black
        
        let textFontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        let text:NSString = "Hello world"
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        UIGraphicsEndPDFContext()
        
        return pathForPDF
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
