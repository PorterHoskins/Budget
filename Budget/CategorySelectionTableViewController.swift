//
//  CategoriesTableViewController.swift
//  Budget
//
//  Created by Porter Hoskins on 7/22/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class CategorySelectionTableViewController: UITableViewController {
    var selectedCategory: Category?
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: (UITableView!)) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return CategorySection.allValues.count
    }

    override func tableView(tableView: (UITableView!), numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let categorySection = CategorySection.allValues[section]
        let categories = Common.categoryController.categories.filter( {c in return c.section == categorySection} )
        
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("category", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let categories = Common.categoryController.categories.filter { c in return c.section == CategorySection.allValues[indexPath.section] }
        
        let category = categories[indexPath.row]
        if indexPath.row == 0 {
            cell.textLabel!.text = category.name
            cell.textLabel!.textColor = UIColor.darkTextColor()
        } else {
            cell.textLabel!.text = " - \(category.name)"
            cell.textLabel!.textColor = UIColor.darkGrayColor()
        }
        
        if let selectedCategory = self.selectedCategory {
            if category == selectedCategory {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
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
