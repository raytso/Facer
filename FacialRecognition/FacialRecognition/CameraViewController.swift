//
//  CameraViewController.swift
//  FacialRecognition
//
//  Created by Ray Tso on 10/9/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

import UIKit
import AVFoundation

private var myContext = 0

class CameraViewController: UIViewController, FaceRectangleDataSource
{
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var faceRectView: FaceDetectedView! {
        didSet {
            faceRectView.dataSource = self
        }
    }
    
    private var faceBounds: CGRect?
    private var faceDetection = FaceDetectionWithCamera(whichCamera: FaceDetectionWithCamera.CameraDevice.frontCamera, detectorAccuracy: FaceDetectionWithCamera.Accuracy.accuracyLo)
    
    
    /* Provide a KVO to observe face bound changes in model */
    // --------------------------------------------------------------------------------
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        faceDetection.addObserver(self, forKeyPath: "faceFeature", options: .New, context: &myContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            if let newChange = change?[NSKeyValueChangeNewKey]{
//                print("\(newChange)")
                faceBounds = newChange.CGRectValue
//                print("\(faceBounds)" + " in controller")
                dispatch_async(dispatch_get_main_queue(),{ () -> Void in self.updateFaceRectView()})
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        faceDetection.removeObserver(self, forKeyPath: "faceFeature")
    }
    // --------------------------------------------------------------------------------

    
    
    func faceBoundsForFaceDetecedView(sender: FaceDetectedView) -> CGRect? {
        return faceBounds
    }
    
    func updateFaceRectView() {
        faceRectView.setNeedsDisplay()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        faceDetection.beginFaceDetection()
        self.view.layer.insertSublayer((faceDetection.previewLayer)!, below: cameraView.layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        faceDetection.endFaceDetection()
//        dismissViewControllerAnimated(true, completion: nil)
        if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAnalyzeView" {
            
            // pass values to AnalyzeViewController
            // Sends popup alert message if face has not been detected yet
            
            if let controller = segue.destinationViewController as? ViewController {
                faceDetection.takePicture()
                let image = faceDetection.userWantedFace
                controller.passedImage = image
            }
        }
    }
    
    
}
