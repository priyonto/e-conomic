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
        reciptIV.image = captureReceipt
    }
}

extension StoreExpenseVC {
    
    fileprivate func bindViewModel() {
        viewModel.fieldValidationResult = { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success:
                // Do something
            case .failure:
                // Show error
                return
            }
        }
        
        validateTextFields()
    }
    
    fileprivate func validateTextFields() {
        viewModel.validateTextFields(place_name: nameTextField.text,
                                     date: dateTextField.text.int64Value,
                                     currency: currencyTextField.text,
                                     amount: amountTextField.text.doubleValue,
                                     category: categoryTextField.text)
    }

}


// MARK:- SETUP UI
extension StoreExpenseVC {
    fileprivate func setupUI() {
        title = "Create Expense Record"
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeTopAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeBottomAnchor,
                          trailing: view.trailingAnchor)
        
        
        scrollView.addSubview(container)
        container.fillSuperview()
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        container.addSubview(reciptIV)
        reciptIV.anchor(top: container.topAnchor,
                        leading: container.leadingAnchor,
                        bottom: nil,
                        trailing: container.trailingAnchor,
                        padding: .init(top: 16, left: 16, bottom: 0, right: 16),
                        size: .init(width: 0, height: 400))
        
        container.addSubview(separator)
        separator.anchor(top: reciptIV.bottomAnchor,
                         leading: reciptIV.leadingAnchor,
                         bottom: nil,
                         trailing: reciptIV.trailingAnchor,
                         padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                         size: .init(width: 0, height: 0.2))
        
        container.addSubview(headerLbl)
        headerLbl.anchor(top: separator.bottomAnchor,
                                leading: separator.leadingAnchor,
                                bottom: nil,
                                trailing: separator.trailingAnchor,
                                padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        
        let textFieldsVStack = VStackView(arrangedSubviews: [
            nameTextField, dateTextField, currencyTextField, amountTextField, categoryTextField
        ], spacing: 8)
        nameTextField.constrainHeight(constant: 44)
        container.addSubview(textFieldsVStack)
        textFieldsVStack.anchor(top: headerLbl.bottomAnchor,
                                leading: headerLbl.leadingAnchor,
                                bottom: nil,
                                trailing: headerLbl.trailingAnchor,
                                padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        
        container.addSubview(storeButton)
        storeButton.anchor(top: textFieldsVStack.bottomAnchor,
                           leading: textFieldsVStack.leadingAnchor,
                           bottom: container.bottomAnchor,
                           trailing: textFieldsVStack.trailingAnchor,
                           padding: .init(top: 34, left: 16, bottom: 16, right: 16),
                           size: .init(width: 0, height: 56))
        
    
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


extension StoreExpenseVC {
    @objc fileprivate func handleRecordCreateTap() {
        validateTextFields()
    }
    
    @objc fileprivate func handleCurrencyChoiceTap() {
        //
        navigateToGenericSelectionScreen(.currency, delegate: self)
    }
    
    @objc fileprivate func handleCategoryChoiceTap() {
        //
        navigateToGenericSelectionScreen(.category, delegate: self)
    }
}
