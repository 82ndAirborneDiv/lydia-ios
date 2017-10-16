//
//  AboutUsViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/14/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit


class AboutUsViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet var webView:UIWebView!
    
    var sc = SiteCatalystService()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)

        
        // Do any additional setup after loading the view, typically from a nib.
        let url = Bundle.main.url(forResource: "about_us", withExtension: "html")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
        webView.delegate = self
        
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
//        self.tabBarController?.moreNavigationController.navigationBarHidden = true
        


    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        let version  = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "0"
        let js_func_call = String(format:"insertVersion(\"%@.%@\")", version as! String, build as! String)
        self.webView.stringByEvaluatingJavaScript(from: js_func_call)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_TITLE_ABOUT, section: sc.SC_SECTION_ABOUT)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

