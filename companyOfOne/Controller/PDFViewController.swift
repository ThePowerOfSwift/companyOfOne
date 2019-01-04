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
        //viewAllPDF()
        createPDF3()

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
    
    func createPDF3(){ //this works loading a PDF from the bundle, doesn't work loading PDF from the picture data
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        pdfView.autoScales = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        guard let path = Bundle.main.url(forResource: "45975", withExtension: "pdf") else { return }
        if let imageData = documentsToDisplay[0].pictureData{
            print("found picture binary data successfully")
            if let pdfData = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters){
                print("converted picture binary data successfully")
                let document  = PDFDocument(data: pdfData)
                    print("created document from converted data successfully")
                    pdfView.document = document
                
            }
        }
//        if let document = PDFDocument(url: path) {
//            pdfView.document = document
//        }
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
