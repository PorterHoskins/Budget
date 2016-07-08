//
//  UIColor+Options.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

extension UIColor {
    class func color(balance: Double, forAccountType accountType: AccountType) -> UIColor! {
        if balance == 0.0 {
            return UIColor.darkTextColor()
        }
        
        switch (accountType) {
        case .Checking, .Savings, .Investment, .Retirement:
            return balance > 0 ? Common.greenColor : Common.redColor
        case .Loan, .CreditCard:
            return balance > 0 ? Common.redColor : Common.greenColor
        default:
            return UIColor.darkTextColor()
        }
    }

    class func color(balance: Double, forTransactionType transactionType: TransactionType) -> UIColor! {
        switch (transactionType) {
        case .Income:
            return Common.greenColor
        default:
            return UIColor.darkTextColor()
        }
    }
}
