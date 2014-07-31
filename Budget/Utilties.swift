//
//  Utilties.swift
//  Budget
//
//  Created by Porter Hoskins on 7/30/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class Utilties {
   
}


class Set<T: Equatable> {
    var items = Array<T>()
    
    func hasItem (that: T) -> Bool {
        // No builtin Array method of hasItem...
        //   because comparison is undefined in builtin Array
        for this: T in items {
            if (this == that) {
                return true
            }
        }
        return false
    }
    
    func insert (that: T) {
        if (!hasItem (that)) {
            items.append (that)
        }
    }
    
    func insert (list: Array<T>) {
        for thing in list {
            if (!hasItem (thing)) {
                items.append (thing)
            }
        }
    }
}