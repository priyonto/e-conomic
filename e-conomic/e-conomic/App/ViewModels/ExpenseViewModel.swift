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
    
    var fieldValidationResult: ((_ result: FieldValidationResponse)->())?
    
    var imageStoreSubscriber: ((_ result: Bool, _ url: URL?) -> ())?
    var expenseStoreSubscriber: ((_ result: Bool) -> (Void))!
    var expenseListSubscriber: ((_ result: [Expense]) -> ())?
    
    
    override init() {
        super.init()
    }
}

extension ExpenseViewModel {
    
    func validateTextFields(place_name: String?, date: Int64?, currency: String?, amount: Double?, category: String? ) {
        guard !place_name.nullOrEmpty else {
            let field = Field(name: .place_name, message: "Enter a valid name")
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard let date = date, date > 0 else {
            let field = Field(name: .date, message: "Enter a valid date")
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard !currency.nullOrEmpty else {
            let field = Field(name: .currency, message: "Select a valid currency")
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard let amount = amount, amount > 0 else {
            let field = Field(name: .amount, message: "Enter a valid amount")
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard !category.nullOrEmpty else {
            let field = Field(name: .category, message: "Select a valid category")
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        fieldValidationResult?(.success)
    }
}

extension ExpenseViewModel {
    func store(with expense: Expense) {
        RealmManager.shared.add(expense.convertToStorage(), completion: expenseStoreSubscriber)
    }

    private func filePath(from name: String) -> URL? {
        let fileManager = FileManager.default
        let documentURL = fileManager.libraryPath()?.appendingPathComponent(name)
        return documentURL
    }
    
    func store(imageData: Data) {
        let fileName = "receipt_" + UUID().uuidString + ".png"
        if let filePath = filePath(from: fileName) {
            do  {
                try imageData.write(to: filePath,
                                            options: .atomic)
                imageStoreSubscriber?(true, filePath)
            } catch {
                imageStoreSubscriber?(false, nil)
            }
        }
    }
}

extension ExpenseViewModel {
    func getExpenses() {
        let objects: [Expense.StorageClass] = RealmManager.shared.get()
        let expenses = objects.map({ Expense.convertFromStorage($0)})
        expenseListSubscriber?(expenses)
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
