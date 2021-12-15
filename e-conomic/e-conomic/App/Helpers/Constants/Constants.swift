//
//  Constants.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation


struct Constants {
    // MARK: - Misc
    static let receiptPrefix = "receipt_"
    static let receiptExt = ".png"
    
    // MARK: - Textfield error messages
    static let enterValidName = "Enter a valid name"
    static let enterValidDate = "Enter a valid date"
    static let selectValidCurrency = "Select a valid currency"
    static let enterValidAmount = "Enter a valid amount"
    static let selectValidCategory = "Select a valid category"
    
    
    // MARK: - Alert messages
    // Title
    static let success = "Success"
    static let errorOccured = "We are sorry!"
    static let requiredFieldTitle = "Required field"
    static let confirmationTitle = "Please confirm"
    
    static let imageAccessTitle = "Allow access to your photos"
    static let imageAccessMessage = "This lets you capture image from camera or choose image from your photo library. Go to your settings and tap \"Photos\"."
    static let selectImageSource = "Please Select Image Source"
    
    static let expenseRecordDeleted = "Expense record deleted successfully"
    static let expenseDeleteError = "Could not delete record. Please try again."
    
    static let deletionConfirmationMsg = "Do you want to delete this?"
    
    
    // MARK: - Image
    static let imageStoreErrorMsg = "Image could not be stored. Please try again."
    
    // MARK: - Data store error
    static let expenseStoreErrorMsg = "Expense could not be stored. Please try again."
    
    // MARK: - Success
    static let expenseStoreSuccess = "Expense record created successfully."
}
