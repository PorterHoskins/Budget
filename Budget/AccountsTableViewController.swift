//
//  AccountsTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 Lampo. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    @IBOutlet  var addAccountButton: UIBarButtonItem?
    @IBOutlet  var addTransactionButton: UIBarButtonItem?
    
    let accountSections = ["Cash", "Investments", "Loans"]
    let accountController = Common.accountController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.editButtonItem()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = addTransactionButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadAccountData", name: Common.NewAccountNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadAccountData", name: Common.NewTransactionNotification, object: nil)
        
        self.editButtonItem().tintColor = UIColor.whiteColor()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func setEditing(editing: Bool, animated: Bool)  {
        super.setEditing(editing, animated: animated)
        
        self.navigationItem.leftBarButtonItem = editing ? addAccountButton : addTransactionButton
    }
    
    func reloadAccountData () {
        tableView.reloadData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return accountSections.count + 1
    }
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        if section == 0 {
            return nil
        }
        
        return accountSections[section - 1]
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return accountsForSection(accountSections[section - 1]).count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier(indexPath.section == 0 ? "netWorth" : "account", forIndexPath: indexPath) as? UITableViewCell
        let nameLabel = cell!.viewWithTag(1) as UILabel
        let amountLabel = cell!.viewWithTag(3) as UILabel
        
        // Configure the cell...
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        //Handle the Net Worth cell
        if indexPath.section == 0 {
            nameLabel.text = "Net Worth"
            
            let netWorth = accountController.netWorth
            amountLabel.text = numberFormatter.stringFromNumber(netWorth)
            amountLabel.textColor = UIColor.color(netWorth, forAccountType: AccountType.Checking)
            
            return cell
        }
        
        let typeLabel = cell!.viewWithTag(2) as UILabel
        
        var accounts = accountsForSection(accountSections[indexPath.section - 1])
        let account = accounts[indexPath.row]
        
        nameLabel.text = account.name
        typeLabel.text = account.type.nameForType
        amountLabel.text = numberFormatter.stringFromNumber(account.balance)
        amountLabel.textColor = UIColor.color(account.balance, forAccountType: account.type)

        return cell
    }
    
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        let amountView = tableView.cellForRowAtIndexPath(indexPath).viewWithTag(3)
        
        UIView.animateWithDuration(1, animations: {
            amountView.frame = CGRectMake(amountView.frame.origin.x - 100, amountView.frame.origin.y, amountView.frame.size.width, amountView.frame.size.height)
            
            }, completion: { success in
                
            })
    }
    
    override func tableView(tableView: UITableView!, didEndEditingRowAtIndexPath indexPath: NSIndexPath!) {
        let amountView = tableView.cellForRowAtIndexPath(indexPath).viewWithTag(3)
        
        UIView.animateWithDuration(1, animations: {
            amountView.frame = CGRectMake(amountView.frame.origin.x + 100, amountView.frame.origin.y, amountView.frame.size.width, amountView.frame.size.height)
            
            }, completion: { success in
                
            })
    }
    
    func accountsForSection(section: String) -> [Account] {
        var accounts = [Account]()
        switch (section) {
        case "Cash":
            if let cashAccounts = accountController.accounts[AccountType.Checking] {
                accounts += cashAccounts
            }
            
            if let savingsAccounts = accountController.accounts[AccountType.Savings] {
                accounts += savingsAccounts
            }
        case "Investments":
            if let investmentAccount = accountController.accounts[AccountType.Investment] {
                accounts += investmentAccount
            }
            
            if let retirementAccounts = accountController.accounts[AccountType.Retirement] {
                accounts += retirementAccounts
            }
        case "Loans":
            if let creditCardAccounts = accountController.accounts[AccountType.CreditCard] {
                accounts += creditCardAccounts
            }
            
            if let loanAccounts = accountController.accounts[AccountType.Loan] {
                accounts += loanAccounts
            }
        default:
            println("No accounts were found")
        }
        
        return accounts
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

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if let transactionsViewController = segue.destinationViewController as? TransactionsTableViewController {
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            var account: Account?
            
            if indexPath.section != 0 {
                account = accountsForSection(accountSections[indexPath.section - 1])[indexPath.row]
            }

            transactionsViewController.account = account
        }
    }

}
