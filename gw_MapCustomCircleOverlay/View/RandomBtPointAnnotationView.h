//
//  CURandomBtPointAnnotationView.h
//  CarUtopia
//
//  Created by 刘功武 on 2021/2/26.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import "RandomBtPointAnnotation.h"

static NSString *RandomBtPointAnnotationViewId = @"RandomBtPointAnnotationView";

@interface RandomBtPointAnnotationView : MAAnnotationView

@property (nonatomic, strong) RandomBtPointAnnotation *btPointAnnotation;

@end
