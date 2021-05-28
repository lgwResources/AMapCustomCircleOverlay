//
//  CUMapCustomCircleOverlay.h
//  CarUtopia
//
//  Created by 刘功武 on 2021/3/3.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/MAMapKit.h>

@interface MapCustomCircleOverlay : NSObject<MAOverlay>

@property (nonatomic, assign) NSInteger routeID;

@property (nonatomic, strong) id<MAOverlay> overlay;

- (id)initWithOverlay:(id<MAOverlay>) overlay;

@end
