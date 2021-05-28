//
//  CURandomBtPointAnnotationView.m
//  CarUtopia
//
//  Created by 刘功武 on 2021/2/26.
//

#import "RandomBtPointAnnotationView.h"

@interface RandomBtPointAnnotationView ()

@property (nonatomic, strong) LOTAnimationView *animationView;

@end

@implementation RandomBtPointAnnotationView

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [LOTAnimationView animationNamed:@"bangpiao"];
        _animationView.loopAnimation = YES;
        _animationView.frame = CGRectMake(0, 0, self.width, self.height);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = _animationView.bounds;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_animationView addSubview:btn];
    }
    return _animationView;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, 40, 40);
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.draggable = NO;
        [self addSubview:self.animationView];
    }
    return self;
}

- (void)setBtPointAnnotation:(RandomBtPointAnnotation *)btPointAnnotation {
    _btPointAnnotation = btPointAnnotation;
    
    [self.animationView play];
}

- (void)btDidClick {
    NSLog(@"self.btPointAnnotation.index=%d",(int)self.btPointAnnotation.index);
}
@end
