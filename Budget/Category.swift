//
//  Category.swift
//  Budget
//
//  Created by Porter Hoskins on 7/22/14.
//  Copyright (c) 2014 PorterHoskins. All rights reserved.
//

import UIKit

class Category: Equatable {
    var section: CategorySection
    var name: String
    
    init (section: CategorySection, withName name: String) {
        self.section = section
        self.name = name
    }
}

func == (lhs: Category, rhs: Category) -> Bool {
    return lhs.section == rhs.section && lhs.name == rhs.name
}

public enum CategorySection: String {
    case Auto = "Auto & Transport"
    case Bills = "Bills & Utilities"
    case Business = "Business Services"
    case Education = "Education"
    case Entertainment = "Entertainment"
    case Fees = "Fees & Charges"
    case Financial = "Financial"
    case Food = "Food & Dining"
    case Gifts = "Gifts & Donations"
    case Health = "Health & Fitness"
    case Home = "Home"
    case Income = "Income"
    case Kids = "Kids"
    case Misc = "Misc Expenses"
    case Personal = "Personal Care"
    case Pets = "Pets"
    case Shopping = "Shopping"
    case Taxes = "Taxes"
    case Transfer = "Transfer"
    case Travel = "Travel"
    case Uncategorized = "Uncategorized"
    
    static let allValues = [Auto, Bills, Business, Education, Entertainment, Fees, Financial, Food, Gifts, Health, Home, Income, Kids, Misc, Personal, Pets, Shopping, Taxes, Transfer, Travel, Uncategorized]
}