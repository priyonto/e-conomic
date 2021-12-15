//
//  GenericSelectionVC+SetupUI.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

// MARK:- SETUP UI
extension GenericSelectionVC {
    func setupUI() {
        view.backgroundColor = .systemBackground
        title = selectionState == .currency ? "Select Currency" : "Select Category"
        
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeTopAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.safeBottomAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 16, left: 0, bottom: 0, right: 0))

    }
    
    func registerCell() {
        collectionView.register(GenericSelectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}


// MARK: - UICOLLECTIONVIEWDELEGAGEFLOWLAYOUT

extension GenericSelectionVC: UICollectionViewDelegateFlowLayout {
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
