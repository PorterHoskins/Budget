//
//  NewTransactionTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class NewTransactionTableViewController: UITableViewController {
    @IBOutlet var nameField: UITextField?
    @IBOutlet var amountField: UITextField?
    @IBOutlet var typeControl: UISegmentedControl?
    @IBOutlet var selectedCategoryCell: UITableViewCell?
    @IBOutlet var selectedAccountCell: UITableViewCell?
    var selectedAccount = Common.accountController.defaultAccount
    
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Select default category
        selectedCategory = Common.categoryController.categories.filter( { c in return c.section == CategorySection.Uncategorized })[0]

        reloadData()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func reloadData() {
        if let selectedAccountCell = selectedAccountCell {
            selectedAccountCell.detailTextLabel!.text = selectedAccount?.name
        }
        
        if let selectedCategoryCell = selectedCategoryCell {
            selectedCategoryCell.detailTextLabel!.text = selectedCategory?.name
        }
    }

    @IBAction func done(sender: AnyObject) {
        if nameField?.text == "" {
            let alert = UIAlertView()
            alert.title = "Enter a name."
            alert.message = "Your transaction needs a name."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        let amount = NSString(string: (amountField?.text!)!).doubleValue
        
        if amountField?.text == "" || (amount == 0.0 && amountField?.text != "0") {
            let alert = UIAlertView()
            alert.title = "Enter an amount."
            alert.message = "Your amount needs a value."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        if amount < 0 {
            let alert = UIAlertView()
            alert.title = "Incorrect Amount"
            alert.message = "Your amount needs to be positive."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        if let selectedAccount = self.selectedAccount {
            var transactionType: TransactionType?
            
            switch (typeControl!.selectedSegmentIndex) {
            case 0:
                transactionType = TransactionType.Expense
            case 1:
                transactionType = TransactionType.Income
            default:
                transactionType = TransactionType.Expense
            }
            
            let transaction = Transaction(amount: amount, withName: nameField!.text!, withType: transactionType!)
            Common.accountController.add(transaction, toAccount:selectedAccount)

            //TODO: Figure out why this will not work
//            NSNotificationCenter.defaultCenter().postNotificationName(Common.NewTransactionNotification, object: transaction)
            
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alert = UIAlertView()
            alert.title = "Missing Account"
            alert.message = "You need to select an account."
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let viewController = segue.destinationViewController as? AccountSelectionTableViewController {
            viewController.selectedAccount = selectedAccount
            viewController.delegate = self
        }
        
        if let viewController = segue.destinationViewController as? CategorySelectionTableViewController {
            viewController.selectedCategory = selectedCategory
            viewController.delegate = self
        }
    }

}
