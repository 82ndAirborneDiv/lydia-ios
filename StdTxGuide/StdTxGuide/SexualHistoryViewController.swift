//
//  SexualHistoryViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 9/17/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit

class SexualHistoryViewController: UIViewController {

    @IBOutlet weak var pdfWebView: UIWebView!
    
    var sc = SiteCatalystService()

    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        self.title = "Sexual History"

        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        let pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("sexualhistory", ofType:"pdf")!) //replace PDF_file with your pdf die name
        let request = NSURLRequest(URL: pdfLoc);
        self.pdfWebView.loadRequest(request);

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_SEXUAL_HISTORY, section: sc.SC_SECTION_SEXUAL_HISTORY)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
