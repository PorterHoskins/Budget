//
//  NewAccountTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 Lampo. All rights reserved.
//

import UIKit

class NewAccountTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var typeCell: UITableViewCell?
    @IBOutlet var nameField: UITextField?
    @IBOutlet var initialBalanceField: UITextField?
    @IBOutlet var pickerView: UIPickerView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if nameField?.text == "" {
            let alert = UIAlertView()
            alert.title = "Enter a name."
            alert.message = "Your account needs a name."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        var balance = NSString(string: initialBalanceField?.text).doubleValue
        
        if initialBalanceField?.text == "" || (balance == 0.0 && initialBalanceField?.text != "0") {
            let alert = UIAlertView()
            alert.title = "Enter an initial balance."
            alert.message = "Your initial balance needs a value."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        if balance < 0 {
            let alert = UIAlertView()
            alert.title = "Incorrect Balance"
            alert.message = "Your initial balance needs to be positive."
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return;
        }
        
        if let pickerView = pickerView {
            let accountType = AccountType.fromRaw(pickerView.selectedRowInComponent(0))!
            var newAccount = Account(name: nameField?.text, withInitialBalance: balance, withType: accountType)
            
            Common.accountController.addAccount(newAccount)
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int  {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return AccountType.fromRaw(row)!.nameForType
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        if let typeCell = typeCell {
            typeCell.detailTextLabel.text = AccountType.fromRaw(row)?.nameForType
        }
        
        resignFirstResponders()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView!)  {
        resignFirstResponders()
    }
    
    func resignFirstResponders() {
        if nameField?.isFirstResponder() {
            nameField?.resignFirstResponder()
        }
        
        if initialBalanceField?.isFirstResponder() {
            initialBalanceField?.resignFirstResponder()
        }
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
