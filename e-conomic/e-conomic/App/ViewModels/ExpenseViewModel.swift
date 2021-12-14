//
//  ExpenseViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

class ExpenseViewModel: NSObject {
    
    var currenciesSubscriber: ((_ result: [Currency]) ->())?
    var categoriesSubscriber: ((_ result: [Category]) ->())?
    
    
    override init() {
        super.init()
    }
}

extension ExpenseViewModel {
    
    func getSelectionItems(_ selection: SelectionState) {
        switch selection {
        case .currency:
            currenciesSubscriber?(parseJsonFile(selection))
        case .category:
            categoriesSubscriber?(parseJsonFile(selection))
        }
    }
    
    func parseJsonFile<T: Decodable>(_ selection: SelectionState) -> [T] {
        guard let output = [T].parse(fileName: selection.rawValue) else {
         return []
        }
        return output
    }
    
}
