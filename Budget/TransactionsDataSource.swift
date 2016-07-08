//
//  TransactionsDataSource.swift
//  Budget
//
//  Created by Porter Hoskins on 7/31/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class TransactionsDataSource: NSObject, UITableViewDataSource {
    let dateFormatter = NSDateFormatter()
    let numberFormatter = NSNumberFormatter()
    
    var account: Account?
    var transactions: [(date: NSDate , transactions: [Transaction])]
    
    init(account: Account?, withTransactions transactions: [Transaction])  {
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.account = account
        self.transactions = Array()
        
        if transactions.count == 0 {
            //Do not do the transaction sorting
            return
        }
        
        let sortedTransactions = transactions.sort({ t1, t2 in return t1.date.compare(t2.date) == NSComparisonResult.OrderedDescending })
        var date: NSDate = sortedTransactions[0].date
        var transactionList = [Transaction]()
        for transaction in sortedTransactions {
            if !transaction.date.isSameDay(date) {
                self.transactions += (date: date , transactions: transactionList)
                
                date = transaction.date
                transactionList = [Transaction]()
            }
            
            transactionList.append(transaction)
        }
        
        self.transactions += (date: date , transactions: transactionList)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return transactions.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return transactions[section - 1].transactions.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        
        return dateFormatter.stringFromDate(transactions[section - 1].date)
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell {        var accountType: AccountType?
        var total = 0.0
        if let account = account {
            total = account.balance
            accountType = account.type
        } else {
            total = Common.accountController.netWorth
            accountType = AccountType.Checking //Do this for a positive account balance type
        }
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("total", forIndexPath: indexPath) as UITableViewCell
            let amountLabel = cell.viewWithTag(3) as! UILabel
            
            amountLabel.text = numberFormatter.stringFromNumber(total)
            amountLabel.textColor = UIColor.color(total, forAccountType: accountType!)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("transaction", forIndexPath: indexPath) as UITableViewCell
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let typeLabel = cell.viewWithTag(2) as! UILabel
        let amountLabel = cell.viewWithTag(3) as! UILabel
        
        let transaction = transactions[indexPath.section - 1].transactions[indexPath.row]
        
        nameLabel.text = transaction.name
        
        typeLabel.text = transaction.category.name
        
        amountLabel.text = numberFormatter.stringFromNumber(transaction.amount)
        amountLabel.textColor = UIColor.color(transaction.amount, forTransactionType: transaction.type)
        
        return cell
    }
}
