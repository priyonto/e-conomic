//
//  StoreExpenseVC+SetupUI.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


// MARK: - SETUP UI
extension StoreExpenseVC {
    func setupUI() {
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
    
    func setupDatePicker() {

        dateTextField.inputView = datePicker
        let blankSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(datePickerCancel))
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([cancelButton, blankSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
}
