//
//  Condition.swift
//  CdcContentJsonParser
//
//  Created by jtq6 on 8/4/14.
//  Copyright (c) 2014 jtq6. All rights reserved.
//

import Foundation



class Condition {
    
    var id, parentId:Int
    var hasChildren:Bool
    var title, regimensPage, dxtxPage:String
    var childrenConditions:Array<Condition>
    
    init(id:Int, parentId:Int, title:String, regimensPage:String, dxtxPage:String, children:Array<Condition>) {
        
        self.id = id
        self.parentId = parentId
        self.title = title
        self.hasChildren = false
        self.childrenConditions = children
        self.regimensPage = regimensPage
        self.dxtxPage = dxtxPage
        println("Condition object created with name = \(self.title) has \(self.numberOfChildren()) children.")
        
    }
    

    func numberOfChildren() -> Int {
        return childrenConditions.count
    }
    
    func isRootCondition() -> Bool {
    
        if id == 0 {
            return true
        }
        return false
    }
    
    
}
