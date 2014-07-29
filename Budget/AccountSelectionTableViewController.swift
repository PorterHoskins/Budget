//
//  AccountSelectionTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 Lampo. All rights reserved.
//

import UIKit

class AccountSelectionTableViewController: UITableViewController {
    let accountController = Common.accountController
    var selectedAccount: Account?
    var selectedCell: UITableViewCell?
    var delegate: NewTransactionTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return accountController.accountTypes.count
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let list = accountController.accounts[AccountType.fromRaw(section)!] {
            return list.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return accountController.accountTypes[section].nameForType
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("account", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let accountType = accountController.accountTypes[indexPath.section]
        if let accountList = accountController.accounts[accountType] {
            var account: Account = accountList[indexPath.row]
            cell.textLabel.text = account.name
            
            cell.accessoryType = (selectedAccount? == account ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None)
            
            if selectedAccount? == account {
                selectedCell = cell
            }
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let accountType = accountController.accountTypes[indexPath.section]
        if let accountList = accountController.accounts[accountType] {
            var account: Account = accountList[indexPath.row]
            
            if let viewController = self.delegate {
                viewController.selectedAccount = account
                viewController.reloadData()
                
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                if let theSelectedCell = selectedCell {
                    theSelectedCell.accessoryType = UITableViewCellAccessoryType.None
                }
                
                selectedCell = cell
            }
        }
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
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
