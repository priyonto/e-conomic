//
//  Expense.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import RealmSwift

struct Expense: Decodable {
    let id: String
    let date: Int64
    let placeName: String
    let currencyName: String
    let currencySymbol: String
    let amount: Double
    let category: String
    let receiptURL: URL
}


extension Expense: Storable {
    
    typealias StorageClass = RealmExpense
    
    func convertToStorage() -> StorageClass {
        let storedExpense = StorageClass()
        storedExpense.date = self.date
        storedExpense.place_name = self.placeName
        storedExpense.currency_name = self.currencyName
        storedExpense.currency_symbol = self.currencySymbol
        storedExpense.amount = self.amount
        storedExpense.category = self.category
        storedExpense.receipt_image_name = self.receiptURL.lastPathComponent
        return storedExpense
    }
    
    static func convertFromStorage(_ storage: StorageClass) -> Expense {
        
        let imageURL = FileManager.default.libraryPath()?.appendingPathComponent(storage.receipt_image_name)
        
        let expense = Expense(id: storage._id.stringValue,
                              date: storage.date,
                              placeName: storage.place_name,
                              currencyName: storage.currency_name,
                              currencySymbol: storage.currency_symbol,
                              amount: storage.amount,
                              category: storage.category,
                              receiptURL: imageURL!)
        
        return expense
    }

}
