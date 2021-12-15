//
//  ExpenseVC+SetupUI.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit



// MARK: - SETUP UI
extension ExpensesVC {
    func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Expenses"
        
        view.addSubview(noResultsLbl)
        noResultsLbl.centerInSuperview()
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
        view.addSubview(captureButton)
        captureButton.anchor(top: nil,
                             leading: nil,
                             bottom: view.safeBottomAnchor,
                             trailing: view.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 24, right: 24),
                             size: .init(width: 60, height: 60))
    }
    
    func registerCell() {
        collectionView.register(ExpenseCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}


// MARK: - UICOLLECTIONVIEWDELEGAGEFLOWLAYOUT

extension ExpensesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        return .init(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: 0, bottom: 0, right: 0)
    }
}


// SCROLL ACTIONS
extension ExpensesVC {
    
    // Hide the floating button when the scrolling starts, after 0.5 seconds delay
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else {return}
            self.captureButton.alpha = 0
        })
    }
    
    // Show the floating button when the scrolling ends, after 0.5 seconds delay
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else {return}
            self.captureButton.alpha = 1
        })
    }
    
}
