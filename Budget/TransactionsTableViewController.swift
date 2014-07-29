//
//  TransactionsTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/21/14.
//  Copyright (c) 2014 Lampo. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
        
        return "Transactions"
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
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("total", forIndexPath: indexPath) as UITableViewCell
            let amountLabel = cell.viewWithTag(3) as UILabel
            
            amountLabel.text = numberFormatter.stringFromNumber(total)
            amountLabel.textColor = UIColor.color(total, forAccountType: accountType!)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("transaction", forIndexPath: indexPath) as UITableViewCell
        let nameLabel = cell.viewWithTag(1) as UILabel
        let dateLabel = cell.viewWithTag(2) as UILabel
        let amountLabel = cell.viewWithTag(3) as UILabel
        
        
        var transaction: Transaction?
        if let account = account {
            transaction = account.transactions[indexPath.row]
        } else {
            transaction = Common.accountController.allTransactions()[indexPath.row]
        }

        nameLabel.text = transaction!.name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateLabel.text = dateFormatter.stringFromDate(transaction!.date)
        
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
