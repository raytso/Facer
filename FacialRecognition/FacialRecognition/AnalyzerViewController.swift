//
//  AnalyzerViewController.swift
//  FacialRecognition
//
//  Created by Ray Tso on 12/2/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

import UIKit

class AnalyzerViewController: UIViewController {
    
    var imageToBeAnalyzed: UIImage?
    var trainedData: NSArray?
//    private var 
//    private let openCV: OpenCVWrapper
    
//    init() {
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageToBeAnalyzed = UIImage(named: "10/4.bmp")
        
        OpenCVWrapper.processImageWithPCA(imageToBeAnalyzed, flag: false)
        
        
//        OpenCVWrapper.processImageWithPCA(imageToBeAnalyzed!)
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
