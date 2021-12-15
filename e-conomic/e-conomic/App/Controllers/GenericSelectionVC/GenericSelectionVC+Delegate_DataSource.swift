//
//  GenericSelectionVC+Delegate_DataSource.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit



// MARK: - UICOLLECTIONVIEW DELEGATE & DATA SOURCE
extension GenericSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectionState {
        case .currency:
            return viewModel.currencies.count
            
        case .category:
            return viewModel.categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? GenericSelectionCell else {
            fatalError()
        }
        switch selectionState {
        case .currency:
            cell.configure(with: viewModel.currencies[indexPath.item])
            
        case .category:
            cell.configure(with: viewModel.categories[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Go back to previous screen
        switch selectionState {
        case .currency:
            delegate?.didSelectItem(item: viewModel.currencies[indexPath.item])
            
        case .category:
            delegate?.didSelectItem(item: viewModel.categories[indexPath.item])
        }
        _ = navigationController?.popViewController(animated: true)
    }
}


// MARK: - Search bar delegate
extension GenericSelectionVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.reset()
            return
        }
        viewModel.search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reset()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKey = searchBar.text, !searchKey.isEmpty else {
            return
        }
        viewModel.search(searchKey)
    }
}
