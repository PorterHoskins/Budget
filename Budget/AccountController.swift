//
//  DataController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class AccountController {
//    class let instance = DataController()
    let accountTypes = [AccountType.Checking, AccountType.Savings, AccountType.Retirement, AccountType.Investment, AccountType.CreditCard, AccountType.Loan]
    var accounts = [AccountType:[Account]]()
    
    init () {}
    
    //MARK: Transactions
    
    private var transactionCache: [Transaction]?
    func allTransactions() -> [Transaction] {
        if let transactionCache = transactionCache {
            return transactionCache
        }
        
        var transactions = [Transaction]()
        for (type, accounts) in self.accounts {
            for account in accounts {
                for transaction in account.transactions {
                    transactions.append(transaction)
                }
            }
        }
        
        //Sort by date and name
        transactions.sort { transaction1, transaction2 in return transaction1.date.compare(transaction2.date) == NSComparisonResult.OrderedDescending }
        transactions.sort { t1, t2 in return t1.name.compare(t2.name) == NSComparisonResult.OrderedAscending}
        
        transactionCache = transactions
        
        return transactions
    }
    
    func invalidateTransactionCache() {
        transactionCache = nil
    }
    
    func add(transaction: Transaction, toAccount account: Account) {
        invalidateTransactionCache()
        
        account.add(transaction)
        
        NSNotificationCenter.defaultCenter().postNotificationName(Common.NewTransactionNotification, object: transaction)
    }
    
    //MARK: Accounts
    
    var defaultAccount: Account? {
    get {
        if let checkingAccount = accounts[AccountType.Checking] {
            return checkingAccount[0]
        }
        
        return nil
    }
    }
    
    func addAccount (account: Account) {
        let accountList = accounts[account.type]
        var newList = [Account]()
        
        if let list = accountList {
            for account in list {
                newList.append(account)
            }
        }
        
        newList.append(account)
        accounts[account.type] = newList
        
        NSNotificationCenter.defaultCenter().postNotificationName(Common.NewAccountNotification, object: account)
    }
    
    var netWorth: Double {
    get {
        var balance = 0.0
        
        for (type, list) in accounts {
            for account in list {
                switch (account.type) {
                case .Checking, .Savings, .Investment, .Retirement:
                    balance += account.balance
                case .CreditCard, .Loan:
                    balance -= account.balance
                }
            }
        }
        
        return balance
    }
    }
}
