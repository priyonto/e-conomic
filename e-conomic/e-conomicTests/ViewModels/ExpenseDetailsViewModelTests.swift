//
//  ExpenseDetailsViewModelTests.swift
//  e-conomicTests
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import XCTest
@testable import e_conomic

class ExpenseDetailsViewModelTests: XCTestCase {
    
    func testInit() {
        
        let expense = Expense(id: "123123",
                              date: 1639575886303,
                              placeName: "Coop Mega",
                              currencyName: "Norwegian Kroner",
                              currencySymbol: "kr.",
                              amount: 1200,
                              category: "Grocery",
                              receiptURL: URL(string: "var/mobile/documents/receipt_12123123.png")!)
        
        let viewModel = ExpenseDetailsViewModel(expense)
        
        XCTAssertEqual(viewModel.date, DateFormatter.dateTimeFormatter.string(from: Date(milliseconds: expense.date)))
        XCTAssertEqual(viewModel.place, "Spent at: \(expense.placeName)")
        XCTAssertEqual(viewModel.category, "Category: \(expense.category)")
        XCTAssertEqual(viewModel.currency, "Currency: \(expense.currencyName)")
        XCTAssertEqual(viewModel.cost, "Total: \(expense.currencySymbol) \(expense.amount)")
        XCTAssertEqual(viewModel.image, assetManager.retrieveImage(url: expense.receiptURL))
        
        
        
    }
    
}
