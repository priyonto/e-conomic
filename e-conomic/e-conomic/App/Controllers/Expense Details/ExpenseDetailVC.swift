//
//  ExpenseDetailVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

class ExpenseDetailsVC: UIViewController {
    
    init(_ expense: Expense) {
        super.init(nibName: nil, bundle: nil)
        self.expense = expense
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- VARIABLES
    
    fileprivate var expense: Expense!
    
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
    
    lazy var dateLbl = UILabel(text: "Mon, December 13, 2021", font: .AppleSDGothicNeo(.medium, size: 20), numberOfLines: 1)
    lazy var categoryLbl = UILabel(text: "Category: Food", numberOfLines: 1)
    lazy var currencyLbl = UILabel(text: "Currency: BDT", numberOfLines: 1)
    lazy var costLbl = UILabel(text: "Kr. 1200", font: .AppleSDGothicNeo(.bold, size: 26), numberOfLines: 1)
    lazy var placeLbl = UILabel(text: "Spent at: Scandic Soli", numberOfLines: 1)
    lazy var separator = UIView(color: .label)
    lazy var reciptIV: UIImageView = {
        let iv = UIImageView(image: nil, backgroundColor: .systemBackground, contentMode: .scaleAspectFill, cornerRadius: 6)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageTap)))
        return iv
    }()
    lazy var fullscreenIV = UIImageView(image: nil, backgroundColor: .systemBackground, contentMode: .scaleAspectFit)
    lazy var closeButton: UIButton = {
        let button = UIButton(title: "Close", titleColor: .label, font: .AppleSDGothicNeo(.semiBold, size: 16))
        button.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
}

extension ExpenseDetailsVC {
    fileprivate func updateUI() {
        dateLbl.text = DateFormatter.dateTimeFormatter.string(from: Date(milliseconds: expense.date))
        placeLbl.text = "Spent at: \(expense.placeName)"
        categoryLbl.text = "Category: \(expense.category)"
        currencyLbl.text = "Currency: \(expense.currencyName)"
        costLbl.text = "Total: \(expense.currencySymbol) \(expense.amount)"
        reciptIV.image = retrieveImage(url: expense.receiptURL)
    }
    
    @objc fileprivate func handleImageTap() {
        
        navigationController?.view.addSubview(fullscreenIV)
        fullscreenIV.alpha = 0
        fullscreenIV.fillSuperview()
        fullscreenIV.image = reciptIV.image
        
        navigationController?.view.addSubview(closeButton)
        closeButton.anchor(top: navigationController?.view.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: navigationController?.view.trailingAnchor,
                           padding: .init(top: 48, left: 0, bottom: 0, right: 26))
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else {return}
            self.fullscreenIV.alpha = 1
            self.closeButton.alpha = 1
            }, completion: { _ in
        })
    }
    
    private func retrieveImage(url: URL) -> UIImage? {
        if let fileData = FileManager.default.contents(atPath: url.path),
            let image = UIImage(data: fileData) {
            return image
        }
        return nil
    }
    
    @objc fileprivate func handleCloseTap() {
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else {return}
            self.closeButton.alpha = 0
            self.fullscreenIV.alpha = 0
            }, completion: { _ in
                self.closeButton.removeFromSuperview()
                self.fullscreenIV.removeFromSuperview()
        })
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
                        bottom: container.bottomAnchor,
                        trailing: separator.trailingAnchor,
                        padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 500))
        
    }
}
