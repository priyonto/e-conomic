//
//  ExpenseDetailsViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import UIKit


struct ExpenseDetailsViewModel {
    
    // notifier to notify whether the delete request is complete
    var expenseDeleteSubscriber: ((_ result: Bool) -> (Void))!
    
    
    //
    
    var date: String
    var place: String
    var category: String
    var currency: String
    var cost: String
    var image: UIImage?
    

    init(_ expense: Expense) {
        self.date = DateFormatter.dateTimeFormatter.string(from: Date(milliseconds: expense.date))
        self.place = "Spent at: \(expense.placeName)"
        self.category = "Category: \(expense.category)"
        self.currency = "Currency: \(expense.currencyName)"
        self.cost = "Total: \(expense.currencySymbol) \(expense.amount)"
        self.image = assetManager.retrieveImage(url: expense.receiptURL)
    }
    
}


extension ExpenseDetailsViewModel {
    
    /// Delete expense model from realm data base and returns the completion handler
    func delete(with expense: Expense) {
        RealmManager.shared.delete(expense, completion: expenseDeleteSubscriber)
    }
}
