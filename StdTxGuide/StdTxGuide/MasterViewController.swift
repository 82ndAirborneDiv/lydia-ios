//
//  MasterViewController.swift
//  StdTxGuide
//
//  Created by jtq6 on 8/1/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var conditions = Array<Condition>()
    let conditionContent = sharedConditionContent

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        conditions = conditionContent.getChildConditions()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
     }
    

    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let condition = conditions[indexPath.row]
            if condition.hasChildren == false {

                (segue.destinationViewController as DetailViewController).detailItem = condition
            } else {
 
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let condition = conditions[indexPath.row]
            if condition.hasChildren == true {
                conditionContent.setCurrentCondition(condition)
                conditions = conditionContent.getChildConditions()
                let mvc:MasterViewController = storyboard.instantiateViewControllerWithIdentifier("MVC") as MasterViewController
                navigationController.pushViewController(mvc, animated: true)
                return false
            } else {
                return true
            }
            
        }
        return false
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let condition = conditions[indexPath.row]
        cell.textLabel.text = condition.title
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }



}

