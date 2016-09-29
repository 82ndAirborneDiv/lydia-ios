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
        
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)
        AppearanceHelper.setTranslucentNavBar(tabBarController!.moreNavigationController.navigationBar)
        
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        super.setNeedsStatusBarAppearanceUpdate()


        // Status bar white font
        self.tabBarController?.tabBar.backgroundColor = UIColor.blue
        self.tabBarController?.customizableViewControllers = nil
        
        // following line is ncessary so that the status bar text is white when the More tab is being displayed.
        self.tabBarController?.moreNavigationController.navigationBar.barStyle = UIBarStyle.black

        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        self.title = "Conditions"
        
        // Do any additional setup after loading the view, typically from a nib.
        conditions = conditionContent.getChildConditions()
        println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
        
        hideBackButton()
        
        displayEula()


    }
    
    func displayEula() {
        
        let userPrefs = UserDefaults.standard
        if let _ = userPrefs.string(forKey: "agreedToEula") {
            return
        } else {
            performSegue(withIdentifier: "showModalEula", sender: self)
            userPrefs.setValue("true", forKey: "agreedToEula")
            if (UIDevice.current.systemVersion as NSString).floatValue < 8.0 {
                userPrefs.synchronize()
            }
        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_TITLE_ALL_CONDITIONS, section: sc.SC_SECTION_CONDITIONS)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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

        } else if segue.identifier == "showSubConditions" {
            let condition = conditionContent.getCurrentCondition()
            let vc = segue.destination as! SubConditionViewController
            vc.currCondition = condition
            
        }

    }
    
    @IBAction func unwindToConditionList(_ segue: UIStoryboardSegue) {
        
        goUpConditionTree()
        
    }
    
    
    @IBAction func backButtonTouch(_ sender:AnyObject) {
        
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConditionCell", for: indexPath) 

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
            performSegue(withIdentifier: "showSubConditions", sender: self)
//            conditions = conditionContent.getChildConditions()
//            showBackButton()
//            println("Current condition childBreadcrumbs = \(self.conditionContent.getCurrentCondition().childBreadcrumbs)")
//            tableView.reloadData()
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

