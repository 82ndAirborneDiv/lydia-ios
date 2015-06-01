//
//  Remote.swift
//  StdTxGuide
//
//  Created by jtq6 on 5/28/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import Foundation
import UIKit


class Remote: NSObject, NSURLConnectionDelegate {
    
    var data = NSMutableData()
    
    func connect(query:NSString) {
        
        var response: NSURLResponse?
        
        var error: NSError?
        
        var origUrl = "http://127.0.0.1:5000/metrics?c54=ios&c55=iphone6&c56=33"
        var url =  NSURL(string:origUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        var request = NSURLRequest(URL: url!)
        var conn = NSURLConnection(request: request, delegate: self, startImmediately: true)

    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        println("didReceiveResponse")
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println(self.data)
    }
    
    
    deinit {
        println("deiniting")
    }
    

}
