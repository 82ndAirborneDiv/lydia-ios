//
//  SubConditionViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 5/19/15.
//  Copyright (c) 2015 jtq6. All rights reserved.
//

import UIKit

class SubConditionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var conditions = Array<Condition>()
    let conditionContent = sharedConditionContent
    var count = 0;
    @IBOutlet var tableView: UITableView!
    @IBOutlet var parentConditionButton: UIBarButtonItem!
    
    var currCondition:Condition!
    var sc = SiteCatalystService()
 

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)

        
        // Status bar white font
        self.tabBarController?.tabBar.backgroundColor = UIColor.blue
        self.tabBarController?.customizableViewControllers = nil
        
        // following line is ncessary so that the status bar text is white when the More tab is being displayed.
        self.tabBarController?.moreNavigationController.navigationBar.barStyle = UIBarStyle.black
                
        // Do any additional setup after loading the view, typically from a nib.
        conditions = conditionContent.getChildConditions()
        println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
        hideBackButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parent = conditionContent.getConditionFromId(conditions[0].parentId)
        sc.trackNavigationEvent(parent.childBreadcrumbs, section: sc.SC_SECTION_CONDITIONS)
        
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConditionDetail" {
            let condition = conditionContent.getCurrentCondition()
            let vc = segue.destination as! ConditionDetailViewController
            vc.condition = condition
            
        }
    }
    
    @IBAction func unwindToConditionList(_ segue: UIStoryboardSegue) {
        
        goUpConditionTree()
        
    }
    
    
    @IBAction func backButtonTouch(_ sender: AnyObject) {
        goUpConditionTree()
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count = conditions.count
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let parent = conditionContent.getConditionFromId(conditions[0].parentId)
        return parent.childBreadcrumbs
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.darkGray
        header.textLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        let headerFrame = header.frame
        header.textLabel!.frame = headerFrame
        header.textLabel!.textAlignment = NSTextAlignment.left
        let parent = conditionContent.getConditionFromId(conditions[0].parentId)
        header.textLabel!.text =  parent.childBreadcrumbs
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubConditionCell", for: indexPath) 
        
        let condition = conditions[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = condition.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let condition = conditions[(indexPath as NSIndexPath).row]
        conditionContent.setCurrentCondition(condition)
        if condition.hasChildren == false {
            performSegue(withIdentifier: "showConditionDetail", sender: self)
            
        } else {
            conditions = conditionContent.getChildConditions()
            showBackButton()
            tableView.reloadData()
            println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
            sc.trackNavigationEvent(self.conditionContent.getCurrentCondition().childBreadcrumbs, section: sc.SC_SECTION_CONDITIONS)

            
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // return false if you do not want the specified item to be editable.
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    
}
