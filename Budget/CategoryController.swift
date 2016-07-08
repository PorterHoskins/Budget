//
//  CategoryController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/22/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class CategoryController {
    var categories = [Category]()
    
    init (){
        let rawCategoryPath = NSBundle.mainBundle().pathForResource("Categories", ofType: "plist")
//        assert(rawCategoryPath != nil, "Could not find the category file!")
        
//        var jsonError: NSError?
        let plist = NSArray(contentsOfFile: rawCategoryPath!)
        
        for section in plist! {
            if let sectionName = CategorySection(rawValue: section.objectForKey("name") as! String!) {
                categories.append(Category(section: sectionName))
                
                for category in section.objectForKey("categories") as! NSArray {
                    categories.append(Category(section: sectionName, withName: category as! String))
                }
            }
        }
    }
    
    func defaultUncategorizedCategory() -> Category {
        return self.categories.filter({c in return c.section == CategorySection.Uncategorized })[0]
    }
    
    func defaultInitialBalanceCategory() -> Category {
        return self.categories.filter({c in return c.section == CategorySection.Transfer })[0]
    }
}
