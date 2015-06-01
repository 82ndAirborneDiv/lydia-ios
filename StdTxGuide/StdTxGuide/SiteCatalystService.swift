//
//  SiteCatalystService.swift
//  StdTxGuide
//
//  Created by jtq6 on 5/22/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import Foundation
import UIKit


class SiteCatalystService: NSObject, NSURLConnectionDelegate {

    var responseData:NSMutableData = NSMutableData()

    let SC_EVENT_APP_LAUNCH = "Application:Launch"
    let SC_EVENT_NAV_SECTION = "Navigation:Section"
    let SC_EVENT_INFO_BUTTON = "Info:Button"
    let SC_EVENT_SHARE_BUTTON = "Share:Button"
    let SC_EVENT_INFO_BROWSE = "Info:Browse"
    let SC_EVENT_CONTENT_BROWSE = "Content:Browse"
    
    let SC_SECTION_CONDITIONS = "Conditions"
    let SC_SECTION_TERMS = "Terms"
    let SC_SECTION_FULL_GUIDELINES = "Full Guidelines"
    let SC_SECTION_SEXUAL_HISTORY = "Sexual History"
    let SC_SECTION_ABOUT = "About Us"
    let SC_SECTION_HELP = "Help"
    let SC_SECTION_EULA = "Agreement"
    
    let SC_PAGE_TITLE_LAUNCH = "STD Tx Guide 2015"
    let SC_PAGE_TITLE_ALL_CONDITIONS = "All Conditions"
    let SC_PAGE_TITLE_INFO = "Information"
    let SC_PAGE_TITLE_ABOUT = "About"
    let SC_PAGE_TITLE_HELP = "Help"
    let SC_PAGE_TITLE_EULA = "EULA"
    
    let cdcServer = "http://tools.cdc.gov/metrics.aspx?"
    let localServer = "http://localhost:5000/metrics?"
    let commonConstParams = "c8=Mobile App&c51=Standalone&c52=STD Tx Guide 2015&c5=eng&channel=IIU"
    let prodConstParams = "reportsuite=cdcsynd"
    let debugConstParams = "reportsuite=devcdc"
    
    func trackEvent(event:String, title:String, section:String)
    {

        println("In trackEvent")
    
        // these first change most often depending on version and if debug is true
        let appVersion = getAppVersion()
        let debug = true
        let debugLocal = true
    
        // server information
        let server = debugLocal ? localServer : cdcServer
    
        // device info
        let deviceParams = String(format:"c54=%@&c55=%@&c56=%@", getDeviceSystemName(), getDeviceSystemVersion(), getDeviceModel())
    
        // application info
        let appInfoParams = String(format:"c53=%@", appVersion)
    
        // set event param
        let eventInfo = String(format:"c58=%@", event)
    
        // set section param
        let sectionInfo = String(format:"c59=%@", section)
    
        // page information
        let pageName = String(format:"contenttitle=%@", title)
    
        // device online status
        let deviceOnline = "c57=1"
    
        let constParams = String(format:"%@&%@", (debug ? debugConstParams : prodConstParams), commonConstParams)
    
        let metricUrl = String(format:"%@%@&%@&%@&%@&%@&%@&%@",server, constParams, deviceParams, appInfoParams, deviceOnline, eventInfo, sectionInfo, pageName)
        let encodedURL = String(format:"%@", metricUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
    
        postSCEvent(encodedURL)
        println("metric URL = %@",metricUrl);
    
    }
    
    func trackAppLaunchEvent()
    {
        trackEvent(SC_EVENT_APP_LAUNCH, title:SC_PAGE_TITLE_LAUNCH, section:SC_SECTION_CONDITIONS)
    
    }
    
    func trackNavigationEvent(pageTitle:String, section:String)
    {
        trackEvent(SC_EVENT_NAV_SECTION, title:pageTitle, section:section)

    }
    
    func postSCEvent(scString:String)
    {
    
        // create request
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string:scString)!)
    
        // Specify that it will be a POST request
        request.HTTPMethod = "GET"
    
        // This is how we set header fields
        request.setValue("application/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
    
        // Convert your data and set your request's HTTPBody property
        let stringData:NSString = ""
        var requestBodyData:NSData = stringData.dataUsingEncoding(NSUTF8StringEncoding)!
        request.HTTPBody = requestBodyData
    
        // Create url connection and fire request
        let conn = NSURLConnection(request:request, delegate:self)
    
    }
    
    
    func connection(connection:NSURLConnection, didReceiveResponse response:NSURLResponse) {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
        responseData = NSMutableData()
    }
    
    func connection(connection:NSURLConnection, didReceiveData data:NSData) {
    // Append the new data to the instance variable you declared
        responseData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, willCacheResponse cachedResponse: NSCachedURLResponse) -> NSCachedURLResponse?
    {
        // don't cache anything
        return nil
    }
    
    func connectionDidFinishLoading(connection:NSURLConnection) {
        // The request is complete and data has been received
        // You can parse the stuff in your instance variable now
        println("Site Catalyst Connection Finished")
    
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("Site Catalyst Connection Error = %@", error)
    }

    
    func getDeviceModel() -> String
    {
        return UIDevice.currentDevice().model
    }
    
    func getDeviceSystemVersion() -> String
    {
        return UIDevice.currentDevice().systemVersion
    }
    
    func getDeviceSystemName() -> String
    {
        return UIDevice.currentDevice().systemName
    }
    
    
    func getAppVersion() -> String
    {
        let dictionary = NSBundle.mainBundle().infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version).\(build)"
    }
    
}

