//
//  LocalConfig.h
//  CarUtopia
//
//  Created by 刘功武 on 2020/9/30.
//

#ifndef LocalConfig_h
#define LocalConfig_h

/**状态栏高度*/
#define stateBarHeight  ([UIApplication sharedApplication].statusBarFrame.size.height)
/**导航栏高度*/
#define nav_Height  64
/**导航栏高度*/
#define navBarHeight  (stateBarHeight+nav_Height)
/**下方工具栏高*/
#define toolsBarHeight (iPhoneX==YES ? 83.0 : 60.0)

#define _bottomM (iPhoneX==YES ? 34.0 : 0.0)

#define segmentViewHeight  45

/**iPhoneX*/
#define iPhoneX ((screenHeight == 812.0f) ? YES : NO)

#define screenHeight    ([UIScreen mainScreen].bounds.size.height)
#define screenWidth     ([UIScreen mainScreen].bounds.size.width)

/** weakSelf */
#define OC_WEAKSELF typeof(self) __weak weakSelf = self

#define BeginIgnoreDeprecatedWarning _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
#define EndIgnoreDeprecatedWarning _Pragma("clang diagnostic pop")

/**统一字体*/
/**中黑体*/
#define CUSTOMEBFONT(A)         [UIFont fontWithName:@"PingFangSC-Medium" size:(A)]
/**常规体*/
#define CUSTOMEFONT(A)          [UIFont fontWithName:@"PingFangSC-Regular" size:(A)]
/**中粗体*/
#define SemiboldFont(A)         [UIFont fontWithName:@"PingFangSC-Semibold" size:(A)]
/**细体*/
#define CUS_LightFont(A)        [UIFont fontWithName:@"PingFangSC-Light" size:(A)]
#define Avenir_HeavyFont(A)     [UIFont fontWithName:@"Avenir-Heavy" size:(A)]

/**色彩设置*/
#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define UIColorFromRGBA_alpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define UIColorFromRGB_alpha(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

/**随机颜色*/
#define RANDOMCOLOR() UIColorFromRGB(rand()%256, rand()%256, rand()%256)

#define c_ffffff   UIColorFromRGBA(0xffffffff)

#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}

#define randomNickName @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

/** 加载本地图片 */
#define ImageForName(imageName) [UIImage imageNamed:imageName]
/**app版本*/
#define app_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**app名称*/
#define app_Name [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#endif /* LocalConfig_h */
