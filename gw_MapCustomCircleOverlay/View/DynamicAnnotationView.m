//
//  DynamicAnnotationView.m
//  CarUtopia
//
//  Created by 刘功武 on 2020/11/5.
//

#import "DynamicAnnotationView.h"

@interface DynamicAnnotationView ()

@end

@implementation DynamicAnnotationView

- (UIImageView *)customView {
    if (!_customView) {
        _customView = [[UIImageView alloc] initWithFrame:self.bounds];
        _customView.image = [UIImage imageNamed:@"map_direction"];
    }
    return _customView;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        self.frame = CGRectMake(0, 0, 85, 85);
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.draggable = NO;
        [self addSubview:self.customView];
    }
    return self;
}

- (void)setAnnotationImageTransformWithDegree:(double)degree {
    self.customView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f);
}
@end
