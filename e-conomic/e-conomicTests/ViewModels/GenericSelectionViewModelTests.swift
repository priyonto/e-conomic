//
//  GenericSelectionViewModelTests.swift
//  e-conomicTests
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import XCTest
@testable import e_conomic

class GenericSelectionViewModelTests: XCTestCase {
    
    func testInitWithCurrencySelection() {
        
        let viewModel = GenericSelectionViewModel(.currency)
        XCTAssertEqual(viewModel.currencies.count, 156)
        
    }
    
    func testInitWithCategorySelection() {
        
        let viewModel = GenericSelectionViewModel(.category)
        XCTAssertEqual(viewModel.categories.count, 8)
        
    }
    
}
