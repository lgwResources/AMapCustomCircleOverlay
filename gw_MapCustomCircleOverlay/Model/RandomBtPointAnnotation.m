//
//  CURandomBtPointAnnotation.m
//  CarUtopia
//
//  Created by 刘功武 on 2021/2/26.
//

#import "RandomBtPointAnnotation.h"

@implementation RandomBtPointAnnotation

+ (instancetype)modelWithCoordinate:(CLLocationCoordinate2D)coordinate {
    RandomBtPointAnnotation *infoModel = [[RandomBtPointAnnotation alloc] init];
    infoModel.coordinate = coordinate;
    return infoModel;
}

@end
