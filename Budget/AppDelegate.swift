//
//  AppDelegate.swift
//  Budget
//
//  Created by Porter Hoskins on 7/20/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = Common.greenColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UISegmentedControl.appearance().tintColor = Common.greenColor
        UITableViewCell.appearance().tintColor = Common.greenColor
        UITabBar.appearance().tintColor = Common.greenColor
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName :  UIColor.whiteColor()];
        
        //TESTING
        let account = Account(name: "Cash", withInitialBalance: 0.0, withType: AccountType.Checking)
        let transaction = Transaction(amount: 200, withName: "Test 1", withType: TransactionType.Expense)
        transaction.date = NSDate(year: 2014, month: 05, day: 11)
        
        let transaction2 = Transaction(amount: 300, withName: "Test 2", withType: TransactionType.Expense)
        transaction2.date = NSDate(year: 2014, month: 05, day: 12)
        
        account.add(transaction)
        account.add(transaction2)
        
        Common.accountController.accounts[AccountType.Checking] = [account]
        
        Common.categoryController
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

