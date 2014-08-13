//
//  ConditionDetailViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/1/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit

class ConditionDetailViewController: UIViewController {
                            
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var parentConditionButton: UIBarButtonItem!


    var detailItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        detailDescriptionLabel.text = detailItem

    }
    
    override func viewDidAppear(animated: Bool) {
        // detailDescriptionLabel.text = "Loaded!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

