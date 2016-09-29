//
//  ConditionContent.swift
//  CdcContentJsonParser
//
//  Created by jtq6 on 8/5/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import Foundation

let sharedConditionContent = ConditionContent()

class ConditionContent {
    
    let CONTENT_MAP_FILENAME = "condition-content-map"
    let CONTENT_MAP_FILE_EXT = "txt"
    var rootCondition:Condition! = nil
    var currCondition:Condition! = nil
    var allConditions:Array<Condition>
    var showingDetail:Bool = false
    
    init () {
        
        rootCondition = nil
        allConditions = Array<Condition>()
        
        println("Initializing ConditionContent object....")
        println("Using file \(CONTENT_MAP_FILENAME).\(CONTENT_MAP_FILE_EXT)......")
        let path = Bundle.main.path(forResource: CONTENT_MAP_FILENAME, ofType: CONTENT_MAP_FILE_EXT)
        
        var jsonData: Data?
        do {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        } catch _ as NSError {
            
        }
        
        var jsonCondition: Dictionary<String, AnyObject>?
        do {
            jsonCondition = try JSONSerialization.jsonObject(with: jsonData!, options: []) as? Dictionary<String, AnyObject>
        } catch {
            
        }
        
        println("JSON loaded, initializing Condition objects....")
        rootCondition = parseConditions(jsonCondition!)
        currCondition = rootCondition
        dumpConditions()
    }
    
    func resetCurrentCondition() {
        currCondition = rootCondition
    }
    
    func dumpConditions() {
        for c:Condition in allConditions {
            println("Condition: \(c.title) had id=\(c.id) and parent id = \(c.parentId)")
        }
    }
    
    func getChildConditions() -> Array<Condition> {
        
        return currCondition!.childrenConditions
        
    }
    
    func isCurrentConditionRootCondition() -> Bool {
        
        if currCondition.id == rootCondition.id {
            return true
        }
        
        return false
    }
    
    func setCurrentConditionToParent() {
        if currCondition?.id != 0 {
            setCurrentCondition(getConditionFromId(currCondition!.parentId))
        } else {
            setCurrentCondition(rootCondition!)
        }
    }
    
    func getCurrentCondition() -> Condition {
        
        return self.currCondition!
    
    }
    
    
    func setCurrentCondition(_ newCondition:Condition) {
    
        currCondition = newCondition
    }
    
    
    func getConditionFromId(_ id:Int) -> Condition {
        for cond in allConditions {
            if cond.id == id {
                return cond
            }
        }
        
        // not found return root
        return rootCondition!
    }
    
    
    func parseConditions(_ conditionJson:Dictionary<String,AnyObject>) ->Condition {
        
        var id:Int = 0
        var parent:Int = 0
        var hasChildren:Bool = false
        var children:Array<Dictionary<String,AnyObject>>
        var childConditions:Array<Condition> = Array<Condition>()
        var text:String = ""
        var regimensPage:String = ""
        var childBreadcrumbs:String = ""
        var dxtxPage:String = ""
        
        for (key, value) in conditionJson {
            switch (key as String) {
            case "condition_id":
                id = value as! Int
                println("Id: \(id)")
                break
            case "hasChildren":
                hasChildren = value as! Bool
                println("hasChildren: \(hasChildren)")
                break
            case "parent":
                if id == 0 {
                    parent = -1
                } else {
                    parent = value as! Int
                    println("Parent: \(parent)")
                }
                break
            case "text":
                text = value as! String
                println("Text: \(text)")
                break
            case "dxtxPage":
                dxtxPage = value as! String
                println("DxtTx Page: \(dxtxPage)")
                break
            case "regimensPage":
                regimensPage = value as! String
                println("Regimens Page: \(regimensPage)")
                break
            case "children":
                children = value as! Array<Dictionary<String, AnyObject>>
                println("Found \(children.count) children")
                for child in children {
                    childConditions.append(parseConditions(child))
                }
                break
            case "childBreadcrumbs":
                childBreadcrumbs = value as! String
                break
            default:
                print("")
            }
            
        }
        
        let condition:Condition = Condition(id: id, parentId: parent, title: text, regimensPage: regimensPage, dxtxPage: dxtxPage, hasChildren: hasChildren, children: childConditions, childBreadcrumbs:childBreadcrumbs)
        allConditions.append(condition)
        return condition
    }
    
    
}



