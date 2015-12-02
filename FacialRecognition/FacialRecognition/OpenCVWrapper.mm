//
//  OpenCVWrapper.m
//  FacialRecognition
//
//  Created by Ray Tso on 10/2/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//
#include <opencv2/opencv.hpp>
#include "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#include <stdio.h>


using namespace cv;
using namespace std;

@implementation OpenCVWrapper : NSObject

    + (UIImage *)processImageWithOpenCV:(UIImage *)inputImage {
        Mat mat = [inputImage CVMat];
        return [UIImage imageWithCVMat: mat];
    }


@end
