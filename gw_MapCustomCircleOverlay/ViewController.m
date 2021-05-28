//
//  ViewController.m
//  gw_MapCustomCircleOverlay
//
//  Created by 刘功武 on 2021/3/25.
//

#import "ViewController.h"
#import "RandomBtPointModel.h"
#import "RandomBtPointAnnotation.h"
#import "MapCustomCircleOverlay.h"
#import "RandomBtPointAnnotationView.h"
#import "DynamicAnnotationView.h"

@interface ViewController ()<MAMapViewDelegate,AMapGeoFenceManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnimatedAnnotation *annotation;
@property (nonatomic, strong) DynamicAnnotationView *annotationView;

@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D mapUserCoordinate;
/**是否第一次记录位置*/
@property (nonatomic, assign) BOOL isFrist;

//帮票动态坐标
@property (nonatomic, strong) NSMutableArray *btAnnotationArr;
@property (nonatomic, strong) AMapGeoFenceManager *geoFenceManager;
@property (nonatomic, strong) NSMutableArray *circleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFrist = YES;
    [self.view addSubview:self.mapView];
}

- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    [locationManager requestAlwaysAuthorization];
}

#pragma mark - 用户位置 位置或者设备方向更新后，会调用此函数
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    if (self.annotationView != nil) {
        OC_WEAKSELF;
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading - mapView.rotationDegree;
            [weakSelf.annotationView setAnnotationImageTransformWithDegree:degree];
        }];
    }
    
    if(!updatingLocation) return ;
    if (userLocation.location.horizontalAccuracy <= 0) return ;
    
    if (updatingLocation) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        self.mapUserCoordinate = coordinate;
        if (self.isFrist) {
            self.isFrist = NO;
            
            [self obtainRandomBtPoint];
        }
    }
}

#pragma mark - 自定义MAAnnotationView
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        DynamicAnnotationView *annotationView = (DynamicAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:DynamicAnnotationViewId];
        if (annotationView == nil) {
            annotationView = [[DynamicAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:DynamicAnnotationViewId];
        }
        self.annotationView = annotationView;
        return annotationView;
    } else if ([annotation isKindOfClass:[RandomBtPointAnnotation class]]) {
        RandomBtPointAnnotationView *annotationView = (RandomBtPointAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:RandomBtPointAnnotationViewId];
        if (annotationView == nil) {
            annotationView = [[RandomBtPointAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:RandomBtPointAnnotationViewId];
        }
        RandomBtPointAnnotation *pointAnnotation = (RandomBtPointAnnotation *)annotation;
        annotationView.btPointAnnotation = pointAnnotation;
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    if (views.count>0) {
        MAAnnotationView *view = views[0];
        if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
            MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
            r.showsAccuracyRing = false;
            [self.mapView updateUserLocationRepresentation:r];
        }
    }
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    BOOL isContains = MACircleContainsCoordinate(self.startCoordinate, self.mapUserCoordinate, 50);
    if (isContains) {
        return;
    }
}

#pragma mark - 获取随机帮票坐标点
- (void)obtainRandomBtPoint {
    NSString *randomBtPointPath = [[NSBundle mainBundle] pathForResource:@"RandomBtPoint.json" ofType:@""];
    NSData *randomBtPointData = [[NSData alloc] initWithContentsOfFile:randomBtPointPath];
    id jsonData = [NSJSONSerialization JSONObjectWithData:randomBtPointData options:kNilOptions error:nil];
    NSMutableArray *dataArr = [RandomBtPointModel mj_objectArrayWithKeyValuesArray:jsonData];
    
    NSMutableArray *circleArr = [NSMutableArray array];
    for (int i = 0; i<dataArr.count; i++) {
        RandomBtPointModel *infoModel = dataArr[i];
        RandomBtPointAnnotation *annotation = initModelWithCoordinate(CLLocationCoordinate2DMake([infoModel.latitude floatValue], [infoModel.longitude floatValue]));
        annotation.index = 10000+i;
        [self.btAnnotationArr addObject:annotation];
        
        [self addCircleReionForRandomBtPoint:annotation];
        
        MACircle *circle = [MACircle circleWithCenterCoordinate:annotation.coordinate radius:200];
        MapCustomCircleOverlay *customCircleOverlay = [[MapCustomCircleOverlay alloc] initWithOverlay:circle];
        customCircleOverlay.routeID = annotation.index;
        [circleArr addObject:customCircleOverlay];
    }
    OC_WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.btAnnotationArr.count>0) {
            [weakSelf.mapView addAnnotations:weakSelf.btAnnotationArr];
            [weakSelf.mapView addOverlays:circleArr];
        }
    });
}

- (void)addCircleReionForRandomBtPoint:(RandomBtPointAnnotation *)randomBtPoint{
    [self.geoFenceManager addCircleRegionForMonitoringWithCenter:randomBtPoint.coordinate radius:400 customID:[NSString stringWithFormat:@"randomBtPoint_%ld",randomBtPoint.index]];
    
    [self.geoFenceManager addCircleRegionForMonitoringWithCenter:randomBtPoint.coordinate radius:100 customID:[NSString stringWithFormat:@"%ld",randomBtPoint.index]];
}

#pragma mark - AMapGeoFenceManagerDelegate 添加地理围栏完成后的回调，成功与失败都会调用
- (void)amapLocationManager:(AMapGeoFenceManager *)manager doRequireTemporaryFullAccuracyAuth:(CLLocationManager*)locationManager completion:(void(^)(NSError *error))completion {
    [locationManager requestAlwaysAuthorization];
}

- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray<AMapGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"区域检测.添加地理围栏失败%@",error);
    } else {
        AMapGeoFenceRegion *region = [regions firstObject];
        NSLog(@"区域检测.添加地理围栏成功%@",region.customID);
    }
}

#pragma mark - 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(AMapGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"区域检测.定位失败%@",error);
    }else{
        
        NSLog(@"区域检测.状态改变%@",[region description]);
        switch (region.fenceStatus) {
            case AMapGeoFenceRegionStatusInside:
            {
                //在区域内
                if ([customID containsString:@"randomBtPoint_"]) {
                    NSLog(@"customID:进入内圈");
                    
                    OC_WEAKSELF;
                    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([overlay isKindOfClass:[MapCustomCircleOverlay class]]) {
                            
                            MapCustomCircleOverlay *customCircleOverlay = (MapCustomCircleOverlay *)overlay;
                            /* 获取overlay对应的renderer. */
                            MACircleRenderer *overlayRenderer = (MACircleRenderer *)[weakSelf.mapView rendererForOverlay:customCircleOverlay];
                            
                            NSString *overlayId = [NSString stringWithFormat:@"randomBtPoint_%ld",customCircleOverlay.routeID];
                            if ([overlayId isEqualToString:customID]) {
                                overlayRenderer.alpha = 1;
                            }
                        }
                    }];
                }else {
                    OC_WEAKSELF;
                    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([overlay isKindOfClass:[MapCustomCircleOverlay class]]) {
                            MapCustomCircleOverlay *customCircleOverlay = (MapCustomCircleOverlay *)overlay;
                            if (customCircleOverlay.routeID == [customID intValue]) {
                                [weakSelf.mapView removeOverlay:customCircleOverlay];
                            }
                        }
                    }];
                    [weakSelf.mapView.annotations enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(MAPointAnnotation *pointAnnotation, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([pointAnnotation isKindOfClass:[RandomBtPointAnnotation class]]) {
                            RandomBtPointAnnotation *randomAn = (RandomBtPointAnnotation *)pointAnnotation;
                            if (randomAn.index == [customID intValue]) {
                                [weakSelf.mapView removeAnnotation:randomAn];
                            }
                        }
                    }];
                    
                    [manager removeGeoFenceRegionsWithCustomID:customID];
                }
            }
                break;
            case AMapGeoFenceRegionStatusOutside:
            {
                //在区域外
                NSLog(@"customID:%@在区域外,不可拾取帮票",customID);
            }
                break;
            default: {
                //未知
            }
                break;
        }
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MapCustomCircleOverlay class]]) {
        
        MapCustomCircleOverlay *customCircleOverlay = (MapCustomCircleOverlay *)overlay;
        id<MAOverlay> actualOverlay = customCircleOverlay.overlay;
        
        MACircleRenderer *overlayRenderer = [[MACircleRenderer alloc] initWithCircle:actualOverlay];
        overlayRenderer.alpha      = 0;
        overlayRenderer.lineWidth   = 1;
        overlayRenderer.lineCapType = kMALineCapRound;
        overlayRenderer.fillColor   = UIColorFromRGBA_alpha(0xffF8EC4F, 0.1);
        overlayRenderer.strokeColor = UIColorFromRGBA_alpha(0xff00E9FF, 0.06);
        
        return overlayRenderer;
    }
    return nil;
}

- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _mapView.delegate = self;
        [_mapView setZoomLevel:15 animated:YES];
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setRotateCameraEnabled:NO];
        _mapView.showsUserLocation = YES;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        _mapView.allowsBackgroundLocationUpdates = YES;
        [_mapView setCustomMapStyleEnabled:YES];
        [_mapView setCustomMapStyleOptions:[self mapCustomStyleOptions]];
    }
    return _mapView;
}

#pragma mark - 自定义高德地图
- (MAMapCustomStyleOptions *)mapCustomStyleOptions {
    MAMapCustomStyleOptions *options = [[MAMapCustomStyleOptions alloc] init];
    NSString *stylePath = [[NSBundle mainBundle] pathForResource:@"style.data" ofType:@""];
    NSData *styleData = [NSData dataWithContentsOfFile:stylePath];
    options.styleData = styleData;
    
    NSString *styleExtraPath = [[NSBundle mainBundle] pathForResource:@"style_extra.data" ofType:@""];
    NSData *styleExtraData = [NSData dataWithContentsOfFile:styleExtraPath];
    options.styleExtraData = styleExtraData;
    return options;
}

- (NSMutableArray *)btAnnotationArr {
    if (!_btAnnotationArr) {
        _btAnnotationArr = [NSMutableArray array];
    }
    return _btAnnotationArr;
}

- (AMapGeoFenceManager *)geoFenceManager {
    if (!_geoFenceManager) {
        _geoFenceManager = [[AMapGeoFenceManager alloc] init];
        _geoFenceManager.delegate = self;
        _geoFenceManager.pausesLocationUpdatesAutomatically = NO;
        _geoFenceManager.allowsBackgroundLocationUpdates = YES;
        //设置希望侦测的围栏触发行为，默认是侦测用户进入围栏的行为，即AMapGeoFenceActiveActionInside，这边设置为进入，离开触发回调
        _geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside;
    }
    return _geoFenceManager;
}

- (NSMutableArray *)circleArr {
    if (!_circleArr) {
        _circleArr = [NSMutableArray array];
    }
    return _circleArr;
}
@end
