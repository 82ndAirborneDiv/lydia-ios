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
    let SC_SECTION_CONDITION_DETAILS_TREATMENTS = "Condition Details - Treatments"
    let SC_SECTION_CONDITION_DETAILS_MORE_INFO = "Condition Details - More Info"
    let SC_SECTION_TERMS = "Terms"
    let SC_SECTION_FULL_GUIDELINES = "Full Guidelines"
    let SC_SECTION_SEXUAL_HISTORY = "Sexual History"
    let SC_SECTION_ABOUT = "About Us"
    let SC_SECTION_HELP = "Help"
    let SC_SECTION_EULA = "Agreement"
    let SC_SECTION_SUPPORT = "Agreement"
    let SC_SECTION_SHARE = "Agreement"
    
    let SC_PAGE_TITLE_LAUNCH = "STD Tx Guide 2015"
    let SC_PAGE_TITLE_ALL_CONDITIONS = "All Conditions"
    let SC_PAGE_TITLE_INFO = "Information"
    let SC_PAGE_TITLE_ABOUT = "About Us"
    let SC_PAGE_TITLE_HELP = "Help"
    let SC_PAGE_TITLE_EULA = "EULA"
    let SC_PAGE_FULL_GUIDELINES = "Full Guidelines"
    let SC_PAGE_TERMS = "Terms"
    let SC_PAGE_SEXUAL_HISTORY = "Sexual History"
    let SC_PAGE_SHARE = "Share"
    let SC_PAGE_SUPPORT = "Support"
    
    let cdcServer = "http://tools.cdc.gov/metrics.aspx?"
    let localServer = "http://localhost:5000/metrics?"
    let commonConstParams = "c8=Mobile App&c51=Standalone&c52=STD Tx Guide 2015&c5=eng&channel=IIU"
    let prodConstParams = "reportsuite=cdcsynd"
    let debugConstParams = "reportsuite=devcdc"
    
    func trackEvent(_ event:String, title:String, section:String)
    {

        println("In trackEvent")
    
        // these first change most often depending on version and if debug is true
        let appVersion = getAppVersion()
        let debug = false
        let debugLocal = false
    
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
    
        let metrics = String(format:"%@&%@&%@&%@&%@&%@&%@", constParams, deviceParams, appInfoParams, deviceOnline, eventInfo, sectionInfo, pageName)
        let metricsWithEscapes = metrics.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let encodedMetricUrl = String(format:"%@%@",server, metricsWithEscapes!)
    
        postSCEvent(scString: encodedMetricUrl)
        println("metric URL = %@",encodedMetricUrl);
    
    }
    
    func trackAppLaunchEvent()
    {
        trackEvent(SC_EVENT_APP_LAUNCH, title:SC_PAGE_TITLE_LAUNCH, section:SC_SECTION_CONDITIONS)
    
    }
    
    func trackNavigationEvent(_ pageTitle:String, section:String)
    {
        trackEvent(SC_EVENT_NAV_SECTION, title:pageTitle, section:section)

    }
    
    func trackContentBrowseEvent(_ pageTitle:String, section:String)
    {
        trackEvent(SC_EVENT_CONTENT_BROWSE, title:pageTitle, section:section)
        
    }
    
    func postSCEvent(scString:String) {
        
        
        let scUrl = URL(string: scString)
        var urlRequest = URLRequest(url: scUrl!)
        urlRequest.httpMethod = "GET";
        urlRequest.setValue("application/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            data, response, error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.responseData.append(data!)
                }
            }
        }
        task.resume()
    }
    
    
    func oldPostSCEvent(_ scString:String)
    {
    
        // create request
        let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string:scString)!)
    
        // Specify that it will be a POST request
        request.httpMethod = "GET"
    
        // This is how we set header fields
        request.setValue("application/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
    
        // Convert your data and set your request's HTTPBody property
        let stringData:NSString = ""
        let requestBodyData:Data = stringData.data(using: String.Encoding.utf8.rawValue)!
        request.httpBody = requestBodyData
    
        // Create url connection and fire request
        _ = NSURLConnection(request:request as URLRequest, delegate:self)
    
    }
    
    
    func connectionDidFinishLoading(_ connection:NSURLConnection) {
        // The request is complete and data has been received
        // You can parse the stuff in your instance variable now
        println("Site Catalyst Connection Finished")
    
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        println("Site Catalyst Connection Error = %@", error)
    }

    
    func getDeviceModel() -> String
    {
        return UIDevice.current.model
    }
    
    func getDeviceSystemVersion() -> String
    {
        return UIDevice.current.systemVersion
    }
    
    func getDeviceSystemName() -> String
    {
        return UIDevice.current.systemName
    }
    
    
    func getAppVersion() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version).\(build)"
    }
    
}

