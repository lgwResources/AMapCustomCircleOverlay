//
//  CUMapCustomCircleOverlay.m
//  CarUtopia
//
//  Created by 刘功武 on 2021/3/3.
//

#import "MapCustomCircleOverlay.h"

@implementation MapCustomCircleOverlay

#pragma mark - MAOverlay Protocol
- (CLLocationCoordinate2D)coordinate {
    return [self.overlay coordinate];
}

- (MAMapRect)boundingMapRect {
    return [self.overlay boundingMapRect];
}

- (id)initWithOverlay:(id<MAOverlay>)overlay {
    self = [super init];
    if (self) {
        self.overlay = overlay;
    }
    return self;
}

@end
