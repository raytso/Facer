//
//  ImageProcessing.m
//  FacialRecognition
//
//  Created by Ray Tso on 1/20/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

#include <opencv2/opencv.hpp>
#import "ImageProcessing.h"
#import "UIImage+OpenCV.h"
#import <Foundation/Foundation.h>

@implementation ImageProcessing

using namespace cv;
using namespace std;

- (void)trainImages:(cv::Mat) trainimage_mat {
    _num_components = 5;
    Mat data;
//    Mat reconstructed;
    
    printf("Preparing PCA calculation\n");
    PCA pca = PCA(trainimage_mat, Mat(), CV_PCA_DATA_AS_COL, _num_components);
    
    printf("Projecting data...\n");
    // recentering
    for (int i = 0; i < trainimage_mat.cols; i++) {
        trainimage_mat.col(i) = trainimage_mat.col(i) - _mean.t();
    }
    // project to PCA space
    pca.project((trainimage_mat), data);
    
    
    printf("Saving data\n");
    _savedPCA = pca;
    _projectedMat = data.clone();
    _eigenValue = pca.eigenvalues;
    _eigenVector = pca.eigenvectors;
    _mean = pca.mean;
}

- (int)distanceCalulation:(cv::Mat) target {
    
//    Mat m = Mat(1, target.rows*target*cols, CV_64F);
//    Mat tmp = target;
//    Mat m = Mat(1, target.total(), CV_64F);
//    vector<double> array;
//    array.assign(target.datastart, target.dataend);
//    // wtf??
//    memcpy(m.data, array.data(), array.size()*sizeof(float));
    Mat test_coeff;
    Mat m;
    
    m = target.reshape(1,1);
    _savedPCA.project(m.t(), test_coeff);
//    m = (test_coeff - _mean.t());
    
    double dist = 0;
    int index = 0;
    
    Mat training_cache;
    training_cache = _trainCell.t();
    
    dist = norm(m.row(0), training_cache.row(0), NORM_L2);
    
    for (int i = 1; i < _trainCell.cols; i++) {
        double dist_cache = norm(m.row(0), training_cache.row(i), NORM_L2);
        if (dist_cache < dist) {
            dist = dist_cache;
            index = i;
        }
        printf(".");
    }
    printf("\n");
    printf("Done. Closest match: ");
    return int((index/_num_components))+1;
}

//- (double)norm:(cv::Mat) input {
//    
//}

- (cv::Mat)prepareTrainingCell:(NSArray *) pickedTrainingSet :(int) foldersize {
    
    Mat trainingCell;
    printf("Preparing traingCell\n");
    for (int folderindex = 1; folderindex <= foldersize; folderindex++) {
        for (NSString *index in pickedTrainingSet) {
            NSString *path = [NSString stringWithFormat:@"%d/%@.bmp",folderindex, index];
            UIImage *img = [UIImage imageNamed:path];
            Mat matcache = [img CVMat];
//            vector<double> array;
//            array.assign(matcache.datastart, matcache.dataend);
//            Mat m = Mat(1, array.size(), CV_64F);
//            // wtf??
//            memcpy(m.data, array.data(), array.size()*sizeof(float));
            Mat m;
            m = matcache.reshape(1, 1);
            trainingCell.push_back(m);
        }
        printf("%d\n",folderindex);
    }
    return trainingCell.t();
}

@end

