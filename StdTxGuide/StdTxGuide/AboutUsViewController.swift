//
//  AboutUsViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/14/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit


class AboutUsViewController: UIViewController {
    
    
    @IBOutlet var webView:UIWebView!
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSBundle.mainBundle().URLForResource("about_us", withExtension: "html")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
//        self.tabBarController?.moreNavigationController.navigationBarHidden = true
        


    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

