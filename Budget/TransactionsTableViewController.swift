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
    var transactions: [Transaction]?
    var dataSource: TransactionsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let account = account {
            transactions = account.transactions
        } else {
            transactions =  Common.accountController.allTransactions()
        }
        
        dataSource = TransactionsDataSource(account: account, withTransactions: transactions!)
        tableView.dataSource = dataSource
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "reloadData", forControlEvents: UIControlEvents.ValueChanged)
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
    
    func reloadData() {
        self.refreshControl.endRefreshing()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
