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
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // breadcrumbs text label
        lblBreadcrumb.textColor = UIColor.darkGray
        lblBreadcrumb.font = UIFont.boldSystemFont(ofSize: 14)
        lblBreadcrumb.textAlignment = NSTextAlignment.center
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
            lblMoreInfo.isHidden = true;
            lblMoreInfo.isEnabled = false;
            lblTreatments.isHidden = true;
            lblTreatments.isEnabled = false;
            segmentedControl.isHidden = false;
            segmentedControl.isEnabled = true;
            segmentedControl.setEnabled(true, forSegmentAt: 0)
            segmentedControl.setEnabled(true, forSegmentAt: 1)
            segmentedControl.selectedSegmentIndex = 0;
            loadRegimensContent()

            
        } else if condition.hasRegimens == false && condition.hasDxTx == true {
            // the only thing to display is More Info (DxTx) Label
            lblMoreInfo.isHidden = false;
            lblMoreInfo.isEnabled = true;
            lblTreatments.isHidden = true;
            lblTreatments.isEnabled = false;
            segmentedControl.isHidden = true;
            segmentedControl.isEnabled = false;
            loadDxTxContent()
           
        } else if condition.hasRegimens == true && condition.hasDxTx == false {
            // the only thing to display is Treatments (Regimens)
            lblMoreInfo.isHidden = true;
            lblMoreInfo.isEnabled = false;
            lblTreatments.isHidden = false;
            lblTreatments.isEnabled = true;
            segmentedControl.isHidden = true;
            segmentedControl.isEnabled = false;
            loadRegimensContent()

        }
                
        segmentedControl.tintColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
        super.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        //self.webView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }
    

    func loadContent(_ fileName:String) {
        let fileUrl = NSURL.init(fileURLWithPath:fileName).deletingPathExtension?.lastPathComponent
        let url = Bundle.main.url(forResource: fileUrl, withExtension: "html")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
    }
    
    func loadRegimensContent() {
        
        loadContent(condition.regimensPage)
        sc.trackContentBrowseEvent(scBreadcrumb, section: sc.SC_SECTION_CONDITION_DETAILS_TREATMENTS)
   
    }
    
    
    func loadDxTxContent() {
        
        loadContent(condition.dxtxPage)
        sc.trackContentBrowseEvent(scBreadcrumb, section: sc.SC_SECTION_CONDITION_DETAILS_MORE_INFO)
        
    }

    @IBAction func valueChange(_ sender: UISegmentedControl) {
        
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

