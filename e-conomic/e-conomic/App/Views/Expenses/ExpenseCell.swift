//
//  ExpenseCell.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


class ExpenseCell: BaseCollectionViewCell {
    
    // MARK:- VARIABLES
    lazy var dateLbl = UILabel(text: "Mon, December 13, 2021", font: .AppleSDGothicNeo(.medium, size: 20), numberOfLines: 1)
    lazy var categoryLbl = UILabel(text: "Category: Food", numberOfLines: 1)
    lazy var costLbl = UILabel(text: "Kr. 1200", font: .AppleSDGothicNeo(.bold, size: 26), numberOfLines: 1)
    lazy var placeLbl = UILabel(text: "Spent at: Scandic Soli", numberOfLines: 1)
    lazy var separator = UIView(color: .label)
//    lazy var reciptIV = UIImageView(image: nil, backgroundColor: .gray, contentMode: .scaleAspectFill, cornerRadius: 6)
//
    
}

extension ExpenseCell {
    override func setupUI() {

        let container = UIView(color: .systemBackground)
        contentView.addSubview(container)
        container.fillSuperview()
        
        let vStack = VStackView(arrangedSubviews: [
            dateLbl, placeLbl, categoryLbl
        ], spacing: 6)
        
        container.addSubview(vStack)
        vStack.anchor(top: container.topAnchor,
                      leading: container.leadingAnchor,
                      bottom: nil,
                      trailing: nil,
                      padding: .init(top: 4, left: 16, bottom: 0, right: 16))
        
        container.addSubview(costLbl)
        costLbl.anchor(top: nil,
                       leading: vStack.trailingAnchor,
                       bottom: nil,
                       trailing: container.trailingAnchor,
                       padding: .init(top: 0, left: 12, bottom: 0, right: 0),
                       size: .init(width: 120, height: 0))
        costLbl.centerYAnchor.constraint(equalTo: vStack.centerYAnchor).isActive = true
        
        container.addSubview(separator)
        separator.anchor(top: vStack.bottomAnchor,
                         leading: container.leadingAnchor,
                         bottom: container.bottomAnchor,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 4, right: 16),
                         size: .init(width: 0, height: 0.2))
    }
}
