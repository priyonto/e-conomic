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
    
    // MARK:- VARIABLES
    
    fileprivate var captureReceipt: UIImage!
    fileprivate var selectedCategory: Category!
    fileprivate var selectedCurrency: Currency!
    fileprivate var selectedDate: Int64 = 0
    
    //
    
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
    
    // CONSTANTS
    
    fileprivate let viewModel = ExpenseViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        setupDatePicker()
        reciptIV.image = captureReceipt
    }
}

extension StoreExpenseVC {
    
    fileprivate func bindViewModel() {
        viewModel.fieldValidationResult = { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success:
                self.viewModel.store(imageData: self.captureReceipt.pngData()!)
            case .failure(let field):
                print(field)
                // Show error
                return
            }
        }
        
        
        viewModel.imageStoreSubscriber = { [weak self] (success, url) in
            guard let self = self else {return}
            if success {
                self.makeRequest(with: url!)
            } else {
                // image not stored and we can not proceed
                // show error here
            }
        }
        
        viewModel.expenseStoreSubscriber = { [weak self] (success) in
            guard let self = self else {return}
            if success {
                // show success alert
                // and then dismiss on okay
                self.dismiss(animated: true, completion: nil)
            } else {
                // show some error
            }
        }
        
    }
    
    fileprivate func validateTextFields() {
        viewModel.validateTextFields(place_name: nameTextField.text,
                                     date: selectedDate,
                                     currency: currencyTextField.text,
                                     amount: amountTextField.text.doubleValue,
                                     category: categoryTextField.text)
    }
    
    
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

}



extension StoreExpenseVC: GenericSelectionDelegate {
    func didSelectItem(item: Any) {
        if let item = item as? Category {
            categoryTextField.text = item.name
            selectedCategory = item
        } else if let item = item as? Currency {
            currencyTextField.text = "\(item.name) - \(item.symbol)"
            selectedCurrency = item
        } else {
            // something out of the context
        }
    }
    
    
}

// MARK: - Actions

extension StoreExpenseVC {
    @objc fileprivate func handleRecordCreateTap() {
        validateTextFields()
    }
    
    @objc fileprivate func handleCurrencyChoiceTap() {
        navigateToGenericSelectionScreen(.currency, delegate: self)
    }
    
    @objc fileprivate func handleCategoryChoiceTap() {
        navigateToGenericSelectionScreen(.category, delegate: self)
    }
    
    
    @objc func datePickerCancel() {
        dateTextField.resignFirstResponder()
    }
    
    @objc func datePickerDone() {
        if selectedDate != 0 {
            dateTextField.resignFirstResponder()
        } else {
            handleSelectedDate(with: datePicker.date)
            dateTextField.resignFirstResponder()
        }
    }
    
    @objc func dateChanged() {
        handleSelectedDate(with: datePicker.date)
    }
    
    func handleSelectedDate(with date: Date) {
        selectedDate = date.millisecondsSince1970
        dateTextField.text = DateFormatter.dateTimeFormatter.string(from: date)
    }
}
