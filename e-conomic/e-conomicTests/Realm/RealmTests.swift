//
//  RealmTests.swift
//  e-conomicTests
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import XCTest
import RealmSwift
@testable import e_conomic

class RealmTests: XCTestCase {
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RealmTest"
    }
    
    func testStore() {
        // To add
        let expense = RealmExpense()
        expense.place_name = "Coop Mega"
        expense.date = 1639575886303
        expense.currency_name = "Norwegian Kroner"
        expense.currency_symbol = "kr."
        expense.category = "Grocery"
        expense.amount = 1200
        expense.receipt_image_name = "receipt_12123123.png"
        
        let realmTest = try! Realm()
        try! realmTest.write {
            realmTest.add(expense)
        }
        
        // Get
        
        let result = realmTest.objects(RealmExpense.self).first
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.place_name, expense.place_name)
        XCTAssertEqual(result?.date, expense.date)
        XCTAssertEqual(result?.currency_name, expense.currency_name)
        XCTAssertEqual(result?.currency_symbol, expense.currency_symbol)
        XCTAssertEqual(result?.category, expense.category)
        XCTAssertEqual(result?.amount, expense.amount)
        XCTAssertEqual(result?.receipt_image_name, expense.receipt_image_name)
        
        
    }
    
    
    func testDelete() {
        
        let expense = RealmExpense()
        expense.place_name = "Coop Mega"
        expense.date = 1639575886303
        expense.currency_name = "Norwegian Kroner"
        expense.currency_symbol = "kr."
        expense.category = "Grocery"
        expense.amount = 1200
        expense.receipt_image_name = "receipt_12123123.png"
        
        let expense2 = RealmExpense()
        expense2.place_name = "Coop Mega 1"
        expense2.date = 1639575886303
        expense2.currency_name = "Norwegian Kroner"
        expense2.currency_symbol = "kr."
        expense2.category = "Grocery"
        expense2.amount = 1200
        expense2.receipt_image_name = "receipt_12123123.png"
        
        let expense3 = RealmExpense()
        expense3.place_name = "Coop Mega 2"
        expense3.date = 1639575886303
        expense3.currency_name = "Norwegian Kroner"
        expense3.currency_symbol = "kr."
        expense3.category = "Grocery"
        expense3.amount = 1200
        expense3.receipt_image_name = "receipt_12123123.png"

        let realm = try! Realm()
        
        let expenses = realm.objects(RealmExpense.self)
        XCTAssertEqual(expenses.count, 0)

        try! realm.write {
            realm.add(expense)
        }
        XCTAssertEqual(expenses.count, 1)
        
        try! realm.write {
            realm.add(expense2)
        }
        XCTAssertEqual(expenses.count, 2)
        
        try! realm.write {
            realm.add(expense3)
        }
        XCTAssertEqual(expenses.count, 3)
        
        try! realm.write {
            realm.delete(expense3)
        }
        XCTAssertEqual(expenses.count, 2)
    }
}
