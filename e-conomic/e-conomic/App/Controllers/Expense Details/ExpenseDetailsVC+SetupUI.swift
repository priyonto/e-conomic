//
//  ExpenseDetailsVC+SetupUI.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

// MARK:- SETUP UI
extension ExpenseDetailsVC {
    func setupUI() {
        title = "Expense Details"
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeTopAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeBottomAnchor,
                          trailing: view.trailingAnchor)
        
        
        scrollView.addSubview(container)
        container.fillSuperview()
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    
        let vStack = VStackView(arrangedSubviews: [
            dateLbl, placeLbl, categoryLbl, currencyLbl, costLbl
        ], spacing: 4)
        
        container.addSubview(vStack)
        vStack.anchor(top: container.topAnchor,
                      leading: container.leadingAnchor,
                      bottom: nil,
                      trailing: container.trailingAnchor,
                      padding: .init(top: 24, left: 16, bottom: 0, right: 16))
        
        
        container.addSubview(separator)
        separator.anchor(top: vStack.bottomAnchor,
                         leading: container.leadingAnchor,
                         bottom: nil,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 0, right: 16),
                         size: .init(width: 0, height: 0.2))
        
        container.addSubview(reciptIV)
        reciptIV.anchor(top: separator.bottomAnchor,
                        leading: separator.leadingAnchor,
                        bottom: nil,
                        trailing: separator.trailingAnchor,
                        padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 500))
        
        container.addSubview(deleteButton)
        deleteButton.anchor(top: reciptIV.bottomAnchor,
                            leading: separator.leadingAnchor,
                            bottom: container.bottomAnchor,
                            trailing: separator.trailingAnchor,
                            padding: .init(top: 34, left: 16, bottom: 16, right: 16),
                            size: .init(width: 0, height: 56))
        
    }
}
