//
//  ConditionDetailViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/1/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit

class ConditionDetailViewController: UIViewController {
                            
    @IBOutlet var parentConditionButton: UIBarButtonItem!
    @IBOutlet var webView:UIWebView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var condition:Condition!
 
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if condtion has regimens content and set it as selcted index
        // if not use dxtx content
        if condition.hasRegimens == false {
            segmentedControl.setEnabled(false, forSegmentAtIndex: 0)
            segmentedControl.selectedSegmentIndex = 1;
            loadDxTxContent()
        } else {
            segmentedControl.setEnabled(true, forSegmentAtIndex: 0)
            segmentedControl.selectedSegmentIndex = 0;
            loadRegimensContent()
            
        }
        
        if condition.hasDxTx == false {
            segmentedControl.setEnabled(false, forSegmentAtIndex: 1)
        } else {
            segmentedControl.setEnabled(true, forSegmentAtIndex: 1)
        }
        
        super.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        //self.webView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin



    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    

    func loadContent(fileName:String) {
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: "html")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }
    
    func loadRegimensContent() {
        
        var fileName = condition.regimensPage.stringByDeletingPathExtension
        loadContent(fileName)
   
    }
    
    
    func loadDxTxContent() {
        
        var fileName = condition.dxtxPage.stringByDeletingPathExtension
        loadContent(fileName)
        
    }

    @IBAction func valueChange(sender: UISegmentedControl) {
        
        // This all works fine and it prints out the value of 3 on any click
        println("# of Segments = \(sender.numberOfSegments)")
        
        switch sender.selectedSegmentIndex {
            case 0:
                loadRegimensContent()
            case 1:
                loadDxTxContent()
            default:
                break;
        }
    }

}

