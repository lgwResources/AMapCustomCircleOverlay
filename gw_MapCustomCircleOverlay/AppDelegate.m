//
//  AppDelegate.m
//  gw_MapCustomCircleOverlay
//
//  Created by 刘功武 on 2021/3/25.
//

#import "AppDelegate.h"
#import "ViewController.h"

/**高德地图*/
#define GDAPIKey @"d13847d5bdeff238368fc05f7988cf0e"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)sharedInstaceAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [ViewController new];
    
    [AMapServices sharedServices].apiKey = GDAPIKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
