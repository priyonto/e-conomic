//
//  ExpenseDetailVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

class ExpenseDetailsVC: UIViewController {
    
    // MARK:- VARIABLES
    
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
    
    lazy var dateLbl = UILabel(text: "Mon, December 13, 2021", font: .AppleSDGothicNeo(.medium, size: 20), numberOfLines: 1)
    lazy var categoryLbl = UILabel(text: "Category: Food", numberOfLines: 1)
    lazy var costLbl = UILabel(text: "Kr. 1200", font: .AppleSDGothicNeo(.bold, size: 26), numberOfLines: 1)
    lazy var placeLbl = UILabel(text: "Spent at: Scandic Soli", numberOfLines: 1)
    lazy var separator = UIView(color: .label)
    lazy var reciptIV = UIImageView(image: nil, backgroundColor: .gray, contentMode: .scaleAspectFill, cornerRadius: 6)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- SETUP UI
extension ExpenseDetailsVC {
    fileprivate func setupUI() {
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
            dateLbl, placeLbl, categoryLbl
        ], spacing: 6)
        
        container.addSubview(vStack)
        vStack.anchor(top: container.topAnchor,
                      leading: container.leadingAnchor,
                      bottom: nil,
                      trailing: nil,
                      padding: .init(top: 24, left: 16, bottom: 0, right: 16))
        
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
                         bottom: nil,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 0, right: 16),
                         size: .init(width: 0, height: 0.2))
        
        container.addSubview(reciptIV)
        reciptIV.anchor(top: separator.bottomAnchor,
                        leading: separator.leadingAnchor,
                        bottom: container.bottomAnchor,
                        trailing: separator.trailingAnchor,
                        padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 400))
        
    }
}
