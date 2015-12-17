//
//  DeviceInfo.m
//  StdTxGuide
//
//  Created by Greg Ledbetter on 12/2/15.
//  Copyright © 2015 jtq6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceInfo.h"

@implementation DeviceInfo


+(BOOL)isDeviceIpad
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    
    return NO;
}


+(NSString *)getDeviceModel
{
    UIDevice *device = [UIDevice currentDevice];
    return [device model];
}


+(NSString *)getDeviceSystemVersion
{
    UIDevice *device = [UIDevice currentDevice];
    return [device systemVersion];
}


+(NSString *)getDeviceSystemName
{
    UIDevice *device = [UIDevice currentDevice];
    return [device systemName];
}



+(NSString *)getAppVersion
{
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *currVersion = [NSString stringWithFormat:@"%@.%@",
                             [appInfo objectForKey:@"CFBundleShortVersionString"],
                             [appInfo objectForKey:@"CFBundleVersion"]];
    
    return currVersion;
    
}


@end