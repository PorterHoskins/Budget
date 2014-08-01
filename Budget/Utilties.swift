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

extension NSDate {
    convenience init(year:Int, month:Int, day:Int) {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        let d = gregorian.dateFromComponents(c)
        self.init(timeInterval: 0, sinceDate: d)
    }
    
    convenience init(dateStr:String, format:String="yyyy-MM-dd") {
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        let d = dateFmt.dateFromString(dateStr)
        self.init(timeInterval: 0, sinceDate: d)
    }
    
    func toString() -> String
    {
        return toString("M/d/yy 'at' h:mm a")
    }
    
    func toString(var format: String) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
    
    func isSameDay(date: NSDate) -> Bool {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let comp1 = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        let comp2 = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: date)
        
        return comp1.day == comp2.day && comp1.month == comp2.month && comp1.year == comp2.year
    }
}