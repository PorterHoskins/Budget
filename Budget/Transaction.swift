//
//  Transaction.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class Transaction {
    var amount = 0.0
    var name: String
    var type: TransactionType
    var date: NSDate
    var category: Category
    
    init (amount: Double, withName name: String, withType type: TransactionType) {
        self.amount = amount
        self.name = name
        self.type = type
        self.date = NSDate()
        
        self.category = Common.categoryController.defaultUncategorizedCategory()
    }
    
    convenience init (amount: Double, withName name: String, withType type: TransactionType, withCategory category: Category) {
        self.init(amount: amount, withName: name, withType: type)
        
        self.category = category
    }
}

enum TransactionType {
    case InitialBalance
    case Income
    case Expense
    
    var nameForType: String {
    get {
        switch (self) {
        case .InitialBalance:
            return "Initial Balance"
        case .Income:
            return "Income"
        case .Expense:
            return "Expense"
        }
    }
    }
}