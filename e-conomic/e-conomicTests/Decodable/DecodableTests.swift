//
//  DecodableTests.swift
//  e-conomicTests
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import XCTest
@testable import e_conomic

class DecodableTests: XCTestCase {

    func testJSONDecodingCurrencies() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "currencies_test", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }

        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: data)
            XCTAssertEqual(currencies.count, 2)
            
            let first = currencies.first
            XCTAssertEqual(first?.name, "Bangladeshi Tk")
            XCTAssertEqual(first?.cc, "BDT")
            XCTAssertEqual(first?.symbol, "Tk")
        } catch {
            XCTFail("Case 1. JSON Decoding for class \([Currency].self) failed.")
        }
    }
    
    
}
