//
//  GenericSelectionCell.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


class GenericSelectionCell: BaseCollectionViewCell {
    
    // MARK:- VARIABLES
    lazy var dataLbl = UILabel(text: "Danish krone - DKK(Kr.)", font: .AppleSDGothicNeo(.regular, size: 16), numberOfLines: 1)
    lazy var separator = UIView(color: .label)
    
}

extension GenericSelectionCell {
    override func setupUI() {

        let container = UIView(color: .systemBackground)
        contentView.addSubview(container)
        container.fillSuperview()
        
        container.addSubview(dataLbl)
        dataLbl.anchor(top: container.topAnchor,
                       leading: container.leadingAnchor,
                       bottom: nil,
                       trailing: container.trailingAnchor,
                       padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        container.addSubview(separator)
        separator.anchor(top: dataLbl.bottomAnchor,
                         leading: dataLbl.leadingAnchor,
                         bottom: container.bottomAnchor,
                         trailing: dataLbl.trailingAnchor,
                         padding: .init(top: 16, left: 0, bottom: 4, right: 0),
                         size: .init(width: 0, height: 0.2))
    }
}


extension GenericSelectionCell {
    func configure(with currency: Currency)  {
        dataLbl.text = "\(currency.name) - \(currency.cc)(\(currency.symbol))"
    }
    
    func configure(with category: Category)  {
        dataLbl.text = "\(category.name)"
    }
}
