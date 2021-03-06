//
//  ExpenseDetailVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

class ExpenseDetailsVC: UIViewController {
    
    // MARK: - Dependency Injection
    
    init(_ expense: Expense) {
        super.init(nibName: nil, bundle: nil)
        self.expense = expense
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables
    
    fileprivate var expense: Expense!
    lazy var viewModel = ExpenseDetailsViewModel(expense)
    
    // MARK: - UI Components
    
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
    
    // Button
    lazy var closeButton: UIButton = {
        let button = UIButton(title: "Close", titleColor: .label, font: .AppleSDGothicNeo(.semiBold, size: 16))
        button.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(backgroundColor: .systemRed, title: "Delete Expense Record", font: .AppleSDGothicNeo(.semiBold, size: 20), cornerRadius: 12)
        button.addTarget(self, action: #selector(handleDeleteTap), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        updateUI()
    }
}

// MARK: - ViewModel
extension ExpenseDetailsVC {
    
    fileprivate func bindViewModel() {
        viewModel.expenseDeleteSubscriber = { [weak self] (success) in
            guard let self = self else {return}
            if success {
                self.alert(title: Constants.success, message: Constants.expenseRecordDeleted, dismiss: true)
            } else {
                self.alert(title: Constants.errorOccured, message: Constants.expenseDeleteError)
            }
        }
    }
    
    fileprivate func updateUI() {
        dateLbl.text = viewModel.date
        placeLbl.text = viewModel.place
        categoryLbl.text = viewModel.category
        currencyLbl.text = viewModel.currency
        costLbl.text = viewModel.cost
        reciptIV.image = viewModel.image
    }
}

// MARK: - Actions

extension ExpenseDetailsVC {
    
    /// Handle delete record button
    @objc fileprivate func handleDeleteTap() {
        deletionAlter(title: Constants.confirmationTitle, message: Constants.deletionConfirmationMsg)
    }
    
    /// Show confirmation alert before deleting any record
    func deletionAlter(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            self.viewModel.delete(with: self.expense)
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Show successfully deleted alert
    func alert(title: String?, message: String?, dismiss: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            if dismiss {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Handle the pewview image tap.
    /// This opens the full screen image also enables a close button to dismiss fullscreen mode
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
    
    /// Handle close button tap when image is fullscreen
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

