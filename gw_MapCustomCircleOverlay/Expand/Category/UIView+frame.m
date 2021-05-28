//
//  UIView+frame.m
//  openCar_New
//
//  Created by 刘功武 on 2020/9/15.
//  Copyright © 2020 . All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (void)setX:(CGFloat)x {
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame    = self.frame;
    frame.origin.y  = y;
    self.frame      = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame        = self.frame;
    frame.size.width    = width;
    self.frame          = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame        = self.frame;
    frame.size.height   = height;
    self.frame          = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame    = self.frame;
    frame.size      = size;
    self.frame      = frame;
}

- (CGSize)size {
    return self.frame.size;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame    = self.frame;
    frame.origin.x  = origin.x;
    frame.origin.y  = origin.y;
    self.frame      = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame    = self.frame;
    frame.origin.x  = right - frame.size.width;
    self.frame      = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame    = self.frame;
    frame.origin.y  = y;
    self.frame      = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame    = self.frame;
    frame.origin.y  = bottom - frame.size.height;
    self.frame      = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center  = self.center;
    center.x        = centerX;
    self.center     = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center  = self.center;
    center.y        = centerY;
    self.center     = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

@end
