//
//  ImageProcessing.h
//  FacialRecognition
//
//  Created by Ray Tso on 1/20/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

#ifndef ImageProcessing_h
#define ImageProcessing_h

#endif /* ImageProcessing_h */


#import <UIKit/UIKit.h>

@interface ImageProcessing : NSObject 

- (cv::Mat)prepareTrainingCell:(NSArray *) pickedTrainingSet :(int) foldersize;
- (void)trainImages:(cv::Mat) trainimage_mat;
- (int) distanceCalulation:(cv::Mat) target;

@property cv::Mat trainCell;
@property cv::Mat projectedMat;
@property cv::Mat eigenValue;
@property cv::Mat eigenVector;
@property cv::Mat mean;
@property cv::PCA savedPCA;
@property int num_components;

@end