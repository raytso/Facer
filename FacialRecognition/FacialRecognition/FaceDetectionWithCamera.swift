//
//  FaceDetectionWithCamera.swift
//  FacialRecognition
//
//  Created by Ray Tso on 10/12/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

import Foundation
import CoreImage
import AVFoundation
import ImageIO

class FaceDetectionWithCamera: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    enum CameraDevice {
        case frontCamera
        case backCamera
    }
    
    enum Accuracy {
        case accuracyHi
        case accuracyLo
    }
    
    private var faceDetector: CIDetector?
    private var faceDetectorOptions: [String : AnyObject]?
    private var featuresInImageOptions: [String : AnyObject]?
    dynamic var faceFeature: CGRect
    private var inputImage: CIImage?
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
//    var stillFaceImage: AVCaptureStillImageOutput?
    private var needsOutputImage: Bool = false
    var userWantedFace: UIImage?
    private var cameraOrientation: AVCaptureVideoOrientation?
    private var features: [CIFeature]?
//    private var previewLayerConnection: AVCaptureConnection?
    private var cameraDataOutput: AVCaptureVideoDataOutput?
    private var cameraDataOutputQueue: dispatch_queue_t?
    private var scale = CGFloat(1.8)
    
    init(whichCamera: CameraDevice, detectorAccuracy: Accuracy) {
        self.faceFeature = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init()
        
        captureSession = AVCaptureSession()
        
        self.featuresInImageOptions = [CIDetectorEyeBlink : false, CIDetectorSmile : false]
        
        switch detectorAccuracy {
        case .accuracyHi:
            self.faceDetectorOptions = [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        case .accuracyLo:
            self.faceDetectorOptions = [CIDetectorAccuracy : CIDetectorAccuracyLow, CIDetectorTracking : true]
//            self.faceDetectorOptions = [CIDetectorAccuracy : CIDetectorAccuracyLow]
        }
        
        switch whichCamera {
        case .frontCamera:
            self.captureSetup(AVCaptureDevicePosition.Front)
            self.featuresInImageOptions![CIDetectorImageOrientation] = 6
        case .backCamera:
            self.captureSetup(AVCaptureDevicePosition.Back)
        }
        
        self.faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: faceDetectorOptions)
        
        
//        captureSetup(AVCaptureDevicePosition.Front)
    }
    
    private func captureSetup (devicePosition: AVCaptureDevicePosition) {
        var captureError: NSError?
        var captureDevice: AVCaptureDevice?
        var deviceInput: AVCaptureDeviceInput?
        
        // Check if capture device has video functionality
        for device in AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) {
            if (device.position == devicePosition) {
                captureDevice = (device as! AVCaptureDevice)
                break
            }
        }
        
        // If capture device doesn't support video functionality, apply a default option
        if (captureDevice == nil) {
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        }
        
        do {
            try deviceInput = AVCaptureDeviceInput(device: captureDevice)
        } catch {
            captureError = error as NSError
        }
        
        if (captureError == nil) {
            // Setting up input
            if captureSession!.canAddInput(deviceInput) {
                captureSession!.addInput(deviceInput)
            }
            
            // Preset640x480
            if captureSession!.canSetSessionPreset(AVCaptureSessionPreset640x480) {
                captureSession?.sessionPreset = AVCaptureSessionPreset640x480
            }
            else {
                print("cannot set settings")
            }
//            // Preset1280x720
//            if captureSession!.canSetSessionPreset(AVCaptureSessionPreset1280x720) {
//                captureSession?.sessionPreset = AVCaptureSessionPreset1280x720
//            }
//            else {
//                print("cannot set settings")
//            }
            
            // Setup camera settings
            cameraDataOutput = AVCaptureVideoDataOutput()
            
            /*???*/
            cameraDataOutput!.videoSettings = [kCVPixelBufferPixelFormatTypeKey: Int(kCVPixelFormatType_32BGRA)]  // Adding Int() fixes ambiguous problem, not sure why though
            
//            cameraDataOutput?.videoSettings = [kCVPixelBufferPixelFormatTypeKey : Int(kCVPixelFormatType_16Gray)]
            
            cameraDataOutput!.alwaysDiscardsLateVideoFrames = true
            cameraDataOutputQueue = dispatch_queue_create("CameraDataOutputQueue", DISPATCH_QUEUE_SERIAL)
            
            cameraDataOutput!.setSampleBufferDelegate(self, queue: cameraDataOutputQueue)
            /*???*/
            
            // Setting up output
            if (captureSession!.canAddOutput(cameraDataOutput)) {
                captureSession!.addOutput(cameraDataOutput)
            }
        }
//        detectedCameraView.frame = UIScreen.mainScreen().bounds
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        cameraOrientation = previewLayer?.connection.videoOrientation
        previewLayer!.frame = UIScreen.mainScreen().bounds
        print("\(previewLayer?.bounds)")
        
        
//        detectedCameraView.layer.insertSublayer(previewLayer, below: detectedCameraView.layer)
//        detectedCameraView.layer.addSublayer(previewLayer)
        
    }
    
    func beginFaceDetection() {
        self.captureSession!.startRunning()
    }
    
    func endFaceDetection() {
        self.captureSession!.stopRunning()
        self.previewLayer?.removeFromSuperlayer()
    }
    
    private func getfaceBounds(face: CIFeature) -> CGRect {
        return face.bounds
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // This function is called whenever a new frame is available
        
        let pixelBuffer: CVPixelBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer)!
        inputImage = CIImage(CVPixelBuffer: pixelBuffer)
        features = self.faceDetector!.featuresInImage(inputImage!, options: featuresInImageOptions)
//        let features = self.faceDetector?.featuresInImage(inputImage)
        
        print("...")

        for feature in features as! [CIFaceFeature] {
            faceFeature = feature.bounds
//            print("\(faceFeature)")
        }
        
        if needsOutputImage {
            //
//            if let connection: AVCaptureConnection? = stillFaceImage?.connectionWithMediaType(AVMediaTypeVideo){
//                userWantedFace = cropPhoto(inputImage, bounds: faceFeature)
//                needsOutputImage = false
//
//            }
        }
    }
    
    func takePicture() {
//        needsOutputImage = true
//        if let connection: AVCaptureConnection? = stillFaceImage?.connectionWithMediaType(AVMediaTypeVideo){
//            stillFaceImage?.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: {(imageBuffer: CMSampleBufferRef, error: NSError) in
//                
//                var imageData: NSData
//                imageData =
//                
//            })
//            userWantedFace = cropPhoto(inputImage, bounds: faceFeature)
//            needsOutputImage = false
        
//        }
        userWantedFace = cropPhotoAndConvertToUIImage()
    }
    
    private func cropPhotoAndConvertToUIImage() -> UIImage {
        let newImage = inputImage?.imageByCroppingToRect(faceFeature)
        return UIImage(CIImage: newImage!, scale: 1.0, orientation: UIImageOrientation.Right)
    }
}










