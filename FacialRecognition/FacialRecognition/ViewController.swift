//
//  ViewController.swift
//  FacialRecognition
//
//  Created by Ray Tso on 10/1/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var openCVImageView: UIImageView!
    
    var passedImage: UIImage?
    // test only
    var testImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if passedImage != nil {
//            openCVImageView.image = OpenCVWrapper.processImageWithOpenCV(img)
            openCVImageView.image = passedImage
            testImg = UIImage(named: "1/2.bmp")
        } else {
            print("No photo ERROR")
//            openCVImageView.frame.width = openCVImageView.frame.height
            testImg = UIImage(named: "1/2.bmp")
            openCVImageView.image = testImg
        }
        // Do any additional setup after loading the view, typically from a nib.
//        testImg = UIImage(named: "3/10.bmp")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "backToCamera" {
//            if let navController = splitViewController?.viewControllers[1] as? UINavigationController {
//                navController.popToViewController(, animated: true)
//            }
//        }
//    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "processImage" {
//            
//            // pass values to AnalyzeViewController
//            // Sends popup alert message if face has not been detected yet
//            
//            if let controller = segue.destinationViewController as? AnalyzerViewController {
////                faceDetection.takePicture()
////                let image = faceDetection.userWantedFace
//                controller.imageToBeAnalyzed = testImg
//                print("preparing segue")
//            }
//        }
//    }


}

