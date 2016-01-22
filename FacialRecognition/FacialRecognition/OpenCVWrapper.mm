//
//  OpenCVWrapper.m
//  FacialRecognition
//
//  Created by Ray Tso on 10/2/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//
#include <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#import "ImageProcessing.h"
#import <Foundation/Foundation.h>

using namespace cv;
using namespace std;

@implementation OpenCVWrapper : NSObject

+ (UIImage *)processImageWithPCA:(UIImage *)inputImage
                            flag:(BOOL)isDataTrained {
    // input image for recognition
    Mat matImage = [inputImage CVMat];
    NSArray *selectSet = @[@1, @3, @5, @7, @9];
    int filesize = 65;
    ImageProcessing *alg = [[ImageProcessing alloc] init];

    // prepare training data
    if (!isDataTrained) {
        alg.trainCell = [alg prepareTrainingCell:selectSet :filesize];
        [alg trainImages:alg.trainCell];
    }
    
    // some mechanism to improve training data for future usage
    
    
    // calculating distance
    printf("Running through database\n");
    
    int match = [alg distanceCalulation:matImage];
    
    printf("%d\n",match);
    
    return [UIImage imageWithCVMat: matImage];
}


@end
