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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK:- SETUP UI
extension StoreExpenseVC {
    fileprivate func setupUI() {
        title = "Store Expense"
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeTopAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeBottomAnchor,
                          trailing: view.trailingAnchor)
        
        
        scrollView.addSubview(container)
        container.fillSuperview()
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    
    }
}
