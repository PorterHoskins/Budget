//
//  CategoryController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/22/14.
//  Copyright (c) 2014 Lampo. All rights reserved.
//

import UIKit

class CategoryController {
    var categories = [Category]()
    
    init (){
        let rawCategoryPath = NSBundle.mainBundle().pathForResource("Categories", ofType: "plist")
//        assert(rawCategoryPath != nil, "Could not find the category file!")
        
        var jsonError: NSError?
        let plist = NSArray(contentsOfFile: rawCategoryPath)
        
        for section in plist {
            if let sectionName = CategorySection.fromRaw(section.objectForKey("name") as String!) {
                for category in section.objectForKey("categories") as NSArray {
                    categories.append(Category(section: sectionName, withName: category as String))
                }
            }
        }
    }
}
