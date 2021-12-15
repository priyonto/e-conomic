//
//  ExpenseCell.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


class ExpenseCell: BaseCollectionViewCell {
    
    // MARK: - UI COMPONENTS VARIABLES
    lazy var dateLbl = UILabel(text: "Mon, December 13, 2021", font: .AppleSDGothicNeo(.medium, size: 20), numberOfLines: 1)
    lazy var categoryLbl = UILabel(text: "Category: Food", numberOfLines: 1)
    lazy var currencyLbl = UILabel(text: "Currency: BDT", numberOfLines: 1)
    lazy var costLbl = UILabel(text: "Kr. 1200", font: .AppleSDGothicNeo(.bold, size: 20), numberOfLines: 1)
    lazy var placeLbl = UILabel(text: "Spent at: Scandic Soli", numberOfLines: 1)
    lazy var separator = UIView(color: .label)

}

// MARK: - CONFIGURE CELL WITH DATA
extension ExpenseCell {
    func configure(from expense: Expense) {
        dateLbl.text = DateFormatter.dateTimeFormatter.string(from: Date(milliseconds: expense.date))
        placeLbl.text = "Spent at: \(expense.placeName)"
        categoryLbl.text = "Category: \(expense.category)"
        currencyLbl.text = "Currency: \(expense.currencyName)"
        costLbl.text = "Total: \(expense.currencySymbol) \(expense.amount)"
    }
    
    /// Make everything nil before reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLbl.text = nil
        placeLbl.text = nil
        categoryLbl.text = nil
        currencyLbl.text = nil
        costLbl.text = nil
    }
}



// MARK: - SETUP UI COMPONENTS
extension ExpenseCell {
    override func setupUI() {

        let container = UIView(color: .systemBackground)
        contentView.addSubview(container)
        container.fillSuperview()
        
        let vStack = VStackView(arrangedSubviews: [
            dateLbl, placeLbl, categoryLbl, currencyLbl, costLbl
        ], spacing: 6)
        
        container.addSubview(vStack)
        vStack.anchor(top: container.topAnchor,
                      leading: container.leadingAnchor,
                      bottom: nil,
                      trailing: container.trailingAnchor,
                      padding: .init(top: 4, left: 16, bottom: 0, right: 16))
        
        container.addSubview(separator)
        separator.anchor(top: vStack.bottomAnchor,
                         leading: container.leadingAnchor,
                         bottom: container.bottomAnchor,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 4, right: 16),
                         size: .init(width: 0, height: 0.2))
    }
}
