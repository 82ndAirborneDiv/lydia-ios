//
//  ConditionViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/1/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit



class ConditionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var conditions = Array<Condition>()
    let conditionContent = sharedConditionContent
    var count = 0;
    @IBOutlet
    var tableView: UITableView!
    @IBOutlet
    var parentConditionButton: UIBarButtonItem!
    var sc = SiteCatalystService()


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        super.setNeedsStatusBarAppearanceUpdate()


        // Status bar white font
        self.tabBarController?.tabBar.backgroundColor = UIColor.blueColor()
        self.tabBarController?.customizableViewControllers = nil
        
        // following line is ncessary so that the status bar text is white when the More tab is being displayed.
        self.tabBarController?.moreNavigationController.navigationBar.barStyle = UIBarStyle.Black

        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.title = "Conditions"
        
        // Do any additional setup after loading the view, typically from a nib.
        conditions = conditionContent.getChildConditions()
        println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
        
        hideBackButton()


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_TITLE_ALL_CONDITIONS, section: sc.SC_SECTION_CONDITIONS)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func showBackButton() {
//        parentConditionButton.enabled = true
//        parentConditionButton.title = "Back"
        
    }
    
    func hideBackButton() {
//        parentConditionButton.enabled = false
//        parentConditionButton.title = nil

    }
    
    func goUpConditionTree()
    {
        conditionContent.setCurrentConditionToParent()
        conditions = conditionContent.getChildConditions()
        if conditionContent.currCondition?.id == conditionContent.rootCondition?.id {
            hideBackButton()
         } else {
            showBackButton()
        }
        tableView.reloadData()
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showConditionDetail" {
            let condition = conditionContent.getCurrentCondition()
            let vc = segue.destinationViewController as! ConditionDetailViewController
            vc.condition = condition

        } else if segue.identifier == "showSubConditions" {
            let condition = conditionContent.getCurrentCondition()
            let vc = segue.destinationViewController as! SubConditionViewController
            vc.currCondition = condition
            
        }

    }
    
    @IBAction func unwindToConditionList(segue: UIStoryboardSegue) {
        
        goUpConditionTree()
        
    }
    
    
    @IBAction func backButtonTouch(AnyObject) {
        
        goUpConditionTree()
    }


    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count = conditions.count
        return count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConditionCell", forIndexPath: indexPath) as! UITableViewCell

        let condition = conditions[indexPath.row]
        cell.textLabel?.text = condition.title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let condition = conditions[indexPath.row]
        conditionContent.setCurrentCondition(condition)
        if condition.hasChildren == false {
            performSegueWithIdentifier("showConditionDetail", sender: self)
            
        } else {
            performSegueWithIdentifier("showSubConditions", sender: self)
//            conditions = conditionContent.getChildConditions()
//            showBackButton()
//            println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
//            tableView.reloadData()
        }

    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // return false if you do not want the specified item to be editable.
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

