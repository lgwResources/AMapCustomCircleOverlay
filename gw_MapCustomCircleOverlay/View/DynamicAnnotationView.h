//
//  CUDynamicAnnotationView.h
//  CarUtopia
//
//  Created by 刘功武 on 2020/11/5.
//

#import <AMapNaviKit/AMapNaviKit.h>

static NSString *DynamicAnnotationViewId = @"DynamicAnnotationView";

@interface DynamicAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *customView;

- (void)setAnnotationImageTransformWithDegree:(double)degree;

@end
