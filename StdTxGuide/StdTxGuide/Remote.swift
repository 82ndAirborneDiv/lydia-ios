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
        
        
//        let origUrl = "http://127.0.0.1:5000/metrics?c54=ios&c55=iphone6&c56=33"
//        let url =  NSURL(string:origUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
//        let request = NSURLRequest(URL: url!)
//        var conn = NSURLConnection(request: request, delegate: self, startImmediately: true)

    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: URLResponse!) {
        println("didReceiveResponse")
    }
    
    private func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.append(conData as Data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println(self.data)
    }
    
    
    deinit {
        println("deiniting")
    }
    

}
