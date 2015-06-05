//
//  AppearanceHelper.swift
//  StdTxGuide
//
//  Created by jtq6 on 6/5/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import Foundation
import UIKit


class AppearanceHelper {
    
    class func setTranslucentNavBar(navigationBar:UINavigationBar) {
        
        // this only needs to be done for iOS 7
        // for iOS 8 this is done in AppDelegate by setting appearance translucent property
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0 {
            
            navigationBar.translucent = false
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            
        }
        
    }
    
}