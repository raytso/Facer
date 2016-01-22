//
//  OpenCVWrapper.h
//  FacialRecognition
//
//  Created by Ray Tso on 10/2/15.
//  Copyright © 2015 Ray Tso. All rights reserved.
//

#ifndef OpenCVWrapper_h
#define OpenCVWrapper_h

#endif /* OpenCVWrapper_h */

#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject


//@property cv::Mat eigenValues;
//@property(nonatomic, readonly) cv::Mat trainingMat;
//@property NSArray* meanArray;


+ (UIImage *)processImageWithPCA:(UIImage *)inputImage
                            flag:(BOOL)isDataTrained;
//- (NSArray *)trainData:(NSArray *) trainingDataSet;
//- (std::vector<cv::Mat>)prepareTrainingDataCell: (NSString*)folderPath: (int)classSize: (NSArray*)trainingDataSet;


@end