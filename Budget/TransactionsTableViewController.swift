//
//  TransactionsTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/21/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    var account: Account?
    let dateFormatter = NSDateFormatter()
    let numberFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let account = account {
            self.navigationItem.title = account.name
        }
        else {
            self.navigationItem.title = "All Accounts"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if section == 0 {
            return 1
        } else if let account = account {
            return account.transactions.count
        } else {
            return Common.accountController.allTransactions().count
        }
    }
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        if section == 0 {
            return nil
        } else if let account = account {
            return dateFormatter.stringFromDate(account.listOfDatesForTransactions()[section - 1])
        } else {
            return dateFormatter.stringFromDate(Common.accountController.allTransactionDates()[0])
        }
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 55
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var accountType: AccountType?
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
            let amountLabel = cell.viewWithTag(3) as UILabel
            
            amountLabel.text = numberFormatter.stringFromNumber(total)
            amountLabel.textColor = UIColor.color(total, forAccountType: accountType!)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("transaction", forIndexPath: indexPath) as UITableViewCell
        let nameLabel = cell.viewWithTag(1) as UILabel
        let typeLabel = cell.viewWithTag(2) as UILabel
        let amountLabel = cell.viewWithTag(3) as UILabel
        
        
        var transaction: Transaction?
        var transactionIndex = (indexPath.section - 1) * indexPath.row
        if let account = account {
            transaction = account.transactions[transactionIndex]
        } else {
            transaction = Common.accountController.allTransactions()[transactionIndex]
        }

        nameLabel.text = transaction!.name
        
        typeLabel.text = transaction!.category.name
        
        amountLabel.text = numberFormatter.stringFromNumber(transaction!.amount)
        amountLabel.textColor = UIColor.color(transaction!.amount, forTransactionType: transaction!.type)

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
