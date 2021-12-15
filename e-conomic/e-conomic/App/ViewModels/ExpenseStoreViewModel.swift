//
//  ExpenseStoreViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation


struct ExpenseStoreViewModel {
    
    // notifier to notify validation results of textfields
    var fieldValidationResult: ((_ result: FieldValidationResponse)->())?
    
    // notifier to notify image store to filemanager
    // returns imageURL alongside a boolean success/fail response
    var imageStoreSubscriber: ((_ result: Bool, _ url: URL?) -> ())?
    
    // notifier to notify whether the store request is complete
    var expenseStoreSubscriber: ((_ result: Bool) -> (Void))!
    
    init() {}
}


extension ExpenseStoreViewModel {
    
    // Validate values sent from the controller
    func validateTextFields(place_name: String?, date: Int64?, currency: String?, amount: Double?, category: String? ) {
        guard !place_name.nullOrEmpty else {
            let field = Field(name: .place_name, message: Constants.enterValidName)
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard let date = date, date > 0 else {
            let field = Field(name: .date, message: Constants.enterValidDate)
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard !currency.nullOrEmpty else {
            let field = Field(name: .currency, message: Constants.selectValidCurrency)
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard let amount = amount, amount > 0 else {
            let field = Field(name: .amount, message: Constants.enterValidAmount)
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        guard !category.nullOrEmpty else {
            let field = Field(name: .category, message: Constants.selectValidCategory)
            fieldValidationResult?(.failure(field: field))
            return
        }
        
        fieldValidationResult?(.success)
    }
}

// MARK: - Methods
extension ExpenseStoreViewModel {
    
    /// Store expense model to realm data base and returns the completion handler
    func store(with expense: Expense) {
        RealmManager.shared.add(expense.convertToStorage(), completion: expenseStoreSubscriber)
    }
    
    /// Generate a filemanager url with unique file name
    private func filePath(from name: String) -> URL? {
        let fileManager = FileManager.default
        let documentURL = fileManager.libraryPath()?.appendingPathComponent(name)
        return documentURL
    }
    
    /// Store image to filemanager and returns a completion handler alongside the url
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
