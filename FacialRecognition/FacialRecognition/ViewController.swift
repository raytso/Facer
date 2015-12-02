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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        openCVImageView.frame.width = openCVImageView.frame.height
//        UIImage(named: "1/1.bmp")
        if passedImage != nil {
//            openCVImageView.image = OpenCVWrapper.processImageWithOpenCV(img)
            openCVImageView.image = passedImage
        } else {
            print("No photo ERROR")
        }
        // Do any additional setup after loading the view, typically from a nib.
        
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


}

