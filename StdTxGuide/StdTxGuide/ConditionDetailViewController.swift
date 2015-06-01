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
    @IBOutlet weak var lblTreatments: UILabel!
    @IBOutlet weak var lblMoreInfo: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lblBreadcrumb: UILabel!
    
    let conditionContent = sharedConditionContent
    var condition:Condition!
    var sc = SiteCatalystService()
    var scBreadcrumb = ""

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // breadcrumbs text label
        lblBreadcrumb.textColor = UIColor.darkGrayColor()
        lblBreadcrumb.font = UIFont.boldSystemFontOfSize(14)
        lblBreadcrumb.textAlignment = NSTextAlignment.Center
        let parent = conditionContent.getConditionFromId(condition.parentId)
        
        if parent.childBreadcrumbs == "" {
            lblBreadcrumb.text = condition.title
            scBreadcrumb = condition.title
            
        } else {
            let breadcrumb = parent.childBreadcrumbs + " / " + condition.title
            lblBreadcrumb.text = breadcrumb
            scBreadcrumb = breadcrumb
            
        }
        
        sc.trackNavigationEvent(scBreadcrumb, section: sc.SC_SECTION_CONDITIONS)
        

        
        // check if condtion has regimens content and set it as selcted index
        // if not use dxtx content
        if condition.hasRegimens == true && condition.hasDxTx == true {
            
            // display both so use segmented control
            // the only thing to display is More Info (DxTx) Label
            lblMoreInfo.hidden = true;
            lblMoreInfo.enabled = false;
            lblTreatments.hidden = true;
            lblTreatments.enabled = false;
            segmentedControl.hidden = false;
            segmentedControl.enabled = true;
            segmentedControl.setEnabled(true, forSegmentAtIndex: 0)
            segmentedControl.setEnabled(true, forSegmentAtIndex: 1)
            segmentedControl.selectedSegmentIndex = 0;
            loadRegimensContent()

            
        } else if condition.hasRegimens == false && condition.hasDxTx == true {
            // the only thing to display is More Info (DxTx) Label
            lblMoreInfo.hidden = false;
            lblMoreInfo.enabled = true;
            lblTreatments.hidden = true;
            lblTreatments.enabled = false;
            segmentedControl.hidden = true;
            segmentedControl.enabled = false;
            loadDxTxContent()
           
        } else if condition.hasRegimens == true && condition.hasDxTx == false {
            // the only thing to display is Treatments (Regimens)
            lblMoreInfo.hidden = true;
            lblMoreInfo.enabled = false;
            lblTreatments.hidden = false;
            lblTreatments.enabled = true;
            segmentedControl.hidden = true;
            segmentedControl.enabled = false;
            loadRegimensContent()

        }
                
        segmentedControl.tintColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
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
        sc.trackContentBrowseEvent(scBreadcrumb, section: sc.SC_SECTION_CONDITION_DETAILS_TREATMENTS)

   
    }
    
    
    func loadDxTxContent() {
        
        var fileName = condition.dxtxPage.stringByDeletingPathExtension
        loadContent(fileName)
        sc.trackContentBrowseEvent(scBreadcrumb, section: sc.SC_SECTION_CONDITION_DETAILS_MORE_INFO)
        
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

