//
//  Account.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class Account: Equatable {
    let id = NSUUID()
    var name: String?
    var type: AccountType
    private var _transactions = [Transaction]()
    var transactions: [Transaction] {
    get {
        //TODO: Needs to cache sorted list instead of sorting it each time
        return _transactions
    }
    }
    
    var balance: Double {
    get {
        var balance = 0.0
        for transaction in _transactions {
            switch (transaction.type) {
            case .Expense:
                balance -= transaction.amount
            case .Income, .InitialBalance:
                balance += transaction.amount
            }
        }
        
        return balance
    }
    }
    
    init (name: String?, withInitialBalance initialBalance: Double, withType type: AccountType) {
        self.name = name
        self.type = type
        
        let initalBalanceCategory = Common.categoryController.defaultInitialBalanceCategory()
        _transactions.append(Transaction(amount: initialBalance, withName: "Initial Balance", withType: TransactionType.InitialBalance, withCategory:initalBalanceCategory))
    }
    
    class func listOfDates(transactions: [Transaction]) -> [NSDate] {
        let dates = Set<NSDate>()
        for transaction in transactions {
            dates.insert(transaction.date)
        }
        
        return dates.items
    }
    
    func add(transaction: Transaction) {
        _transactions.append(transaction)
    }
}

func == (lhs: Account, rhs: Account) -> Bool {
    return lhs.id == rhs.id
}

enum AccountType: Int {
    case Checking
    case Savings
    case Investment
    case Retirement
    case CreditCard
    case Loan
    
    var nameForType: String {
    get {
        switch (self) {
        case .Checking:
            return "Checking"
        case .Savings:
            return "Savings"
        case .Investment:
            return "Investment"
        case .Retirement:
            return "Retirement"
        case .CreditCard:
            return "Credit Card"
        case .Loan:
            return "Loan"
        }
    }
    }
}