//
//  GenericSelectionViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

// TODO: -
// Refactor more and improve
// Add search by other parameters alongside name

struct GenericSelectionViewModel {
    
    // Notifier
    
    var currenciesSubscriber: ((_ result: [Currency]) ->())?
    var categoriesSubscriber: ((_ result: [Category]) ->())?
    
    // Variables used by the Controller
    var currencies: [Currency] = []
    var categories: [Category] = []
    
    /// Variables to be used by only view model
    /// These are used to compute the search results and keep the base values immutable
    private var enc_currencies: [Currency] = []
    private var enc_categories: [Category] = []
    
    // Setter
    
    private var selectionState: SelectionState
    
    // Initializer
    init(_ selectionState: SelectionState) {
        self.selectionState = selectionState
        self.getSelectionItems(selectionState)
    }

    // Methods
    mutating func search(_ keyword: String) {
        switch selectionState {
        case .currency:
            let filteredData = enc_currencies.filter({ return $0.name.lowercased().range(of: keyword.lowercased()) != nil })
            currencies = filteredData
            currenciesSubscriber?(filteredData) // Notify Controller
        case .category:
            let filteredData = enc_categories.filter({ return $0.name.lowercased().range(of: keyword.lowercased()) != nil })
            categories = filteredData
            categoriesSubscriber?(filteredData) // Notify Controller
        }
    }
    
    // Methods
    mutating func reset() {
        getSelectionItems(selectionState)
    }
    
    /// Get selected items
    private mutating func getSelectionItems(_ selection: SelectionState) {
        switch selection {
        case .currency:
            enc_currencies = parseJsonFile(selection)
            currencies = enc_currencies
            currenciesSubscriber?(enc_currencies)
        case .category:
            enc_categories = parseJsonFile(selection)
            categories = enc_categories
            categoriesSubscriber?(enc_categories)
        }
    }
    
    /// Parse json file with name
    private func parseJsonFile<T: Decodable>(_ selection: SelectionState) -> [T] {
        guard let output = [T].parse(fileName: selection.rawValue) else {
         return []
        }
        return output
    }
    
}
