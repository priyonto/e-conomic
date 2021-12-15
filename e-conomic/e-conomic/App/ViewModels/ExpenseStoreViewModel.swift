//
//  ExpenseStoreViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation


struct ExpenseStoreViewModel {
    
    var fieldValidationResult: ((_ result: FieldValidationResponse)->())?
    
    var imageStoreSubscriber: ((_ result: Bool, _ url: URL?) -> ())?
    var expenseStoreSubscriber: ((_ result: Bool) -> (Void))!
    
    init() {}
}


extension ExpenseStoreViewModel {
    
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

extension ExpenseStoreViewModel {
    
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
