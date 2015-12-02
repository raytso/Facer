//
//  FaceDetectedView.swift
//  FacialRecognition
//
//  Created by Ray Tso on 10/21/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

import UIKit

protocol FaceRectangleDataSource: class {
    func faceBoundsForFaceDetecedView(sender: FaceDetectedView) -> CGRect?
}

class FaceDetectedView: UIView {
    
    weak var dataSource: FaceRectangleDataSource?
    
    private var color: UIColor = UIColor.yellowColor()
    private var color_test: UIColor = UIColor.blueColor()
    private var viewRectWidth: CGFloat?
    private var viewRectHeight: CGFloat?
    
    struct cameraInputProperty {
        var size = CGSize(width: 640.0, height: 480.0)
        var origin: CGPoint = CGPoint(x: 0, y: 0)
    }
    
    private func transformRect(rect: CGRect, view: CGRect) -> CGRect {
        let input = cameraInputProperty()
        var output = cameraInputProperty()
        var widthScale: CGFloat {
            return view.size.width / input.size.height  //
        }
        var heightScale: CGFloat {
            return view.size.height / input.size.width  // 0.29
        }
        
        output.size.width = rect.size.width * heightScale
        output.size.height = (rect.size.height) * heightScale
        
        output.origin.x = 160 - rect.origin.y * widthScale + 20
        output.origin.y = rect.origin.x * heightScale + 20
        
        return CGRect(origin: output.origin, size: output.size)
    }
    
//    private func transformOrigin()
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        if var faceBounds = dataSource?.faceBoundsForFaceDetecedView(self) {
            faceBounds = transformRect(faceBounds, view: rect)
            let facePath = UIBezierPath(rect: faceBounds)
//            let leftEye = CGRect(origin: faceFeature.leftEyePosition, size: CGSize(width: 20, height: 20))
//            let rightEye = CGRect(origin: faceFeature.rightEyePosition, size: CGSize(width: 20, height: 20))
//            let leftEyePath = UIBezierPath(rect: leftEye)
//            let rightEyePath = UIBezierPath(rect: rightEye)
//            print("\(rightEye)")
//            print("\(leftEye)")
            print("Path updated")
            color.set()
            facePath.stroke()
//            leftEyePath.stroke()
//            rightEyePath.stroke()
        }
    }
}
