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

    
    @IBOutlet weak var viewForImageTest: UIImageView!
    @IBOutlet weak var viewForPDF: UIView!
    
    var documentsToDisplay:[Document] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController!.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = true
        print(documentsToDisplay.count)
        viewAllPDF()

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
    
    func createPDF(image: UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }
    
    func viewAllPDF(){
        let pdfView = PDFView()
//        for document in documentsToDisplay{
        let document = documentsToDisplay[0]
            if let imageData = document.pictureData{
                if let image = UIImage(data: imageData){
                    viewForImageTest.image = image
                     let PDFData = createPDF(image: image)
                    pdfView.document = PDFDocument(data: PDFData! as Data)
//                }
            }
        }
    viewForPDF.addSubview(pdfView)
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
