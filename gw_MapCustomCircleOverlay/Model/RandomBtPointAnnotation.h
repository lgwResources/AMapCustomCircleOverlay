//
//  CURandomBtPointAnnotation.h
//  CarUtopia
//
//  Created by 刘功武 on 2021/2/26.
//

#import <AMapNaviKit/AMapNaviKit.h>

@interface RandomBtPointAnnotation : MAPointAnnotation

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL showRadiusView;

+ (instancetype)modelWithCoordinate:(CLLocationCoordinate2D)coordinate;
@end

static inline RandomBtPointAnnotation *initModelWithCoordinate(CLLocationCoordinate2D coordinate) {
    return [RandomBtPointAnnotation modelWithCoordinate:coordinate];
}
