//
//  DeviceInfo.h
//  StdTxGuide
//
//  Created by Greg Ledbetter on 12/3/15.
//  Copyright © 2015 jtq6. All rights reserved.
//

#ifndef DeviceInfo_h
#define DeviceInfo_h

#import <Foundation/Foundation.h>

@interface DeviceInfo: NSObject

+(BOOL)isDeviceIpad;
+(NSString *)getDeviceModel;
+(NSString *)getDeviceSystemVersion;
+(NSString *)getDeviceSystemName;
+(NSString *)getAppVersion;

@end


#endif /* DeviceInfo_h */
