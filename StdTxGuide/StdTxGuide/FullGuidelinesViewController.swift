//
//  FullGuidelinesViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 2/27/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import UIKit

class FullGuidelinesViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    var sc = SiteCatalystService()

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        let url = Bundle.main.url(forResource: "full", withExtension: "html")
        let request = URLRequest(url:url!)
        webView.scalesPageToFit = true
        webView.delegate = self

        webView.loadRequest(request)
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_FULL_GUIDELINES, section: sc.SC_SECTION_FULL_GUIDELINES)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) ->Bool  {
        
        if (navigationType == UIWebViewNavigationType.linkClicked)
            {
                UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
                return false
        }
        
        return true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
