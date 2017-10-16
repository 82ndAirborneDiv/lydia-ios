//
//  ModalEulaViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 6/9/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import Foundation
import UIKit


class ModalEulaViewController: UIViewController {
    
    
    @IBOutlet var webView:UIWebView!
    @IBAction func btnAgreeTouchUp(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)

    }
    
    var sc = SiteCatalystService()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = Bundle.main.url(forResource: "eula", withExtension: "html")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
        self.tabBarController?.moreNavigationController.isNavigationBarHidden = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_TITLE_EULA, section: sc.SC_SECTION_EULA)
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

