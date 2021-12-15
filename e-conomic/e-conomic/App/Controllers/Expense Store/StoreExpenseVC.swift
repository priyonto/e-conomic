//
//  StoreExpenseVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import UIKit

class StoreExpenseVC: UIViewController {
    
    // DEPENDENCY INJECTION
    init(_ image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.captureReceipt = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VARIABLES
    
    fileprivate var captureReceipt: UIImage!
    fileprivate var selectedDate: Int64 = 0
    
    var selectedCategory: Category!
    var selectedCurrency: Currency!
    
    // MARK: - UI Components
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceHorizontal = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    lazy var container = UIView(color: .clear)
    
    // Separator
    
    lazy var separator = UIView(color: .label)
    
    // Label
    
    lazy var headerLbl = UILabel(text: "Add additional information", font: .AppleSDGothicNeo(.medium, size: 20), alignment: .center)
    
    // Imageview
    
    lazy var reciptIV = UIImageView(image: nil, backgroundColor: .gray, contentMode: .scaleAspectFill, cornerRadius: 6)
    
    // Textfields declaration
    
    lazy var nameTextField = UITextField(placeHolder: "Where did you spend?")
    
    lazy var dateTextField = UITextField(placeHolder: "When did you spend?")
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    
    lazy var currencyTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Select currency")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCurrencyChoiceTap))
        textfield.addGestureRecognizer(tap)
        return textfield
    }()
    
    lazy var amountTextField = UITextField(keyboardType: .decimalPad, placeHolder: "Enter the total amount")
    lazy var categoryTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Choose category")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCategoryChoiceTap))
        textfield.addGestureRecognizer(tap)
        return textfield
    }()
    
    // Button
    lazy var storeButton: UIButton = {
        let button = UIButton(backgroundColor: .systemGreen, title: "Create Expense Record", font: .AppleSDGothicNeo(.semiBold, size: 20), cornerRadius: 12)
        button.addTarget(self, action: #selector(handleRecordCreateTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - CONSTANTS
    fileprivate var viewModel = ExpenseStoreViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDatePicker()
        bindViewModel()
        renderImageView()
    }
    
    fileprivate func renderImageView() {
        reciptIV.image = captureReceipt
    }
}

// MARK: - Methods to bind viewmodel to controller

extension StoreExpenseVC {
    
    fileprivate func bindViewModel() {
        
        /// Subscribes to validation results of viewmodel
        viewModel.fieldValidationResult = { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success:
                self.viewModel.store(imageData: self.captureReceipt.pngData()!)
            case .failure(let field):
                self.alert(title: Constants.requiredFieldTitle, message: field.message)
            }
        }
        
        /// Subscribe to image store status
        /// Once image is stored expense model is passed to viewmodel
        viewModel.imageStoreSubscriber = { [weak self] (success, url) in
            guard let self = self else {return}
            if success {
                self.makeRequest(with: url!)
            } else {
                // image not stored and we can not proceed
                self.alert(title: Constants.errorOccured, message: Constants.imageStoreErrorMsg)
            }
        }
        
        /// Subscribe to expense store state
        viewModel.expenseStoreSubscriber = { [weak self] (success) in
            guard let self = self else {return}
            if success {
                // show success alert
                // and then dismiss on okay
                self.alert(title: Constants.success, message: Constants.expenseStoreSuccess, dismissController: true)
            } else {
                // show some error
            }
        }
        
    }

}

// MARK: - Actions

extension StoreExpenseVC {
    
    /// This method passes the textfield values to the viewmodel to validate
    /// Viewmodel then passes the validated results to the controller with help of closure
    fileprivate func validateTextFields() {
        viewModel.validateTextFields(place_name: nameTextField.text,
                                     date: selectedDate,
                                     currency: currencyTextField.text,
                                     amount: amountTextField.text.doubleValue,
                                     category: categoryTextField.text)
    }
    
    /// This method passes the validated value of the textfields to the viewmodel to store them to the database
    /// Viewmodel then stores the values to the database and notify controller the result
    fileprivate func makeRequest(with url: URL) {
        let expense = Expense(id: "",
                              date: selectedDate,
                              placeName: nameTextField.text!,
                              currencyName: selectedCurrency.name,
                              currencySymbol: selectedCurrency.symbol,
                              amount: amountTextField.text.doubleValue!,
                              category: categoryTextField.text!,
                              receiptURL: url)
        viewModel.store(with: expense)
    }
    
    
    /// Button action on record create tap
    /// This starts validating the textfields
    @objc fileprivate func handleRecordCreateTap() {
        validateTextFields()
    }
    
    /// Button action for currency textfield tap
    /// This takes user to a separate screen to select currency from a list
    @objc fileprivate func handleCurrencyChoiceTap() {
        navigateToGenericSelectionScreen(.currency, delegate: self)
    }
    
    /// Button action for category textfield tap
    /// This takes user to a separate screen to select category from a list
    @objc fileprivate func handleCategoryChoiceTap() {
        navigateToGenericSelectionScreen(.category, delegate: self)
    }
    
    /// This action occurs when cancel is tapped on the datepicker
    @objc func datePickerCancel() {
        dateTextField.resignFirstResponder()
    }
    
    /// This action occurs when done is tapped on the datepicker
    @objc func datePickerDone() {
        if selectedDate != 0 {
            dateTextField.resignFirstResponder()
        } else {
            handleSelectedDate(with: datePicker.date)
            dateTextField.resignFirstResponder()
        }
    }
    
    /// This action occurs when date is changed on the picker
    @objc func dateChanged() {
        handleSelectedDate(with: datePicker.date)
    }
    
    /// This method handles formatting the date after selection and render in the textfield with expected format
    func handleSelectedDate(with date: Date) {
        selectedDate = date.millisecondsSince1970
        dateTextField.text = DateFormatter.dateTimeFormatter.string(from: date)
    }
    
    func alert(title: String?, message: String?, dismissController: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            if dismissController {
                self.dismiss(animated: true, completion: nil)
            }
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
