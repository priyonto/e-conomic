//
//  ExpenseTests.swift
//  e-conomicTests
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import XCTest
@testable import e_conomic

class ExpenseTests: XCTestCase {
    
    func testConvertToStorage() {
        let expense = Expense(id: "",
                              date: 1639575886303,
                              placeName: "Coop Mega",
                              currencyName: "Norwegian Kroner",
                              currencySymbol: "kr.",
                              amount: 1200,
                              category: "Grocery",
                              receiptURL: URL(string: "var/mobile/documents/receipt_12123123.png")!)
        let stored = expense.convertToStorage()
        XCTAssertEqual(expense.date, stored.date)
        XCTAssertEqual(expense.placeName, stored.place_name)
        XCTAssertEqual(expense.currencyName, stored.currency_name)
        XCTAssertEqual(expense.currencySymbol, stored.currency_symbol)
        XCTAssertEqual(expense.category, stored.category)
        XCTAssertEqual(expense.receiptURL.lastPathComponent, stored.receipt_image_name)
        
    }
    
    func testConvertFromStorage() {
        let expense = RealmExpense()
        expense.date = 1639575886303
        expense.place_name = "Coop Mega"
        expense.currency_name = "Norwegian Kroner"
        expense.currency_symbol = "kr."
        expense.amount = 1200
        expense.category = "Grocery"
        expense.receipt_image_name = "receipt_12123123.png"
        
        let convertedExpense = Expense.convertFromStorage(expense)
        
        XCTAssertEqual(convertedExpense.date, expense.date)
        XCTAssertEqual(convertedExpense.placeName, expense.place_name)
        XCTAssertEqual(convertedExpense.currencyName, expense.currency_name)
        XCTAssertEqual(convertedExpense.currencySymbol, expense.currency_symbol)
        XCTAssertEqual(convertedExpense.category, expense.category)
        XCTAssertEqual(convertedExpense.receiptURL.lastPathComponent, expense.receipt_image_name)
    }
    
}
