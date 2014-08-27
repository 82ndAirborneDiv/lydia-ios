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
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSBundle.mainBundle().URLForResource(condition.regimensPage.stringByDeletingPathExtension, withExtension: "html")
        let request = NSURLRequest(URL:url)
        webView.loadRequest(request)

    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidAppear(animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
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
        let request = NSURLRequest(URL:url)
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

