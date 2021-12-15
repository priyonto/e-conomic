//
//  SelectionVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

enum SelectionState: String {
    case currency = "currencies"
    case category = "categories"
}

import UIKit

class GenericSelectionVC: UIViewController {
    
    // DEPENDENCY INJECTION
    init (selectionState: SelectionState, delegate: GenericSelectionDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.selectionState = selectionState
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- VARIABLES
    
    var selectionState: SelectionState = .currency
    weak var delegate: GenericSelectionDelegate?
    
    //
    
    /// Searchbar
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barTintColor = .systemBackground
        sb.tintColor = .label
        sb.barStyle = .default
        sb.placeholder = "Search"
        sb.backgroundColor = .clear
        sb.sizeToFit()
        sb.delegate = self
        return sb
    }()
    
    /// collectionview to hold the list of expense history
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInsetReference = .fromContentInset
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.contentInsetAdjustmentBehavior = .always
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = true
        return cv
    }()
    
    
    // MARK:- CONSTANTS
    
    let viewModel = ExpenseViewModel()
    let cellIdentifier: String = "cellIdentifier"
    let cellHeight: CGFloat = 60
    let spacing: CGFloat = 16
    
    var currencies: [Currency] = []
    var categories: [Category] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        bindViewModel()
    }

}

extension GenericSelectionVC {
    fileprivate func bindViewModel() {
        viewModel.currenciesSubscriber = { [weak self] (result) in
            guard let self = self else {return}
            self.currencies = result
            self.reload()
        }
        
        viewModel.categoriesSubscriber = { [weak self] (result) in
            guard let self = self else {return}
            self.categories = result
            self.reload()
        }
        
        viewModel.getSelectionItems(selectionState)
    }
    
    fileprivate func reload() {
        collectionView.reloadData()
    }
 
}






// MARK:- UICOLLECTIONVIEW DELEGATE & DATA SOURCE
extension GenericSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectionState {
        case .currency:
            return currencies.count
            
        case .category:
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? GenericSelectionCell else {
            fatalError()
        }
        switch selectionState {
        case .currency:
            cell.configure(with: currencies[indexPath.item])
            
        case .category:
            cell.configure(with: categories[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Go back to previous screen
        switch selectionState {
        case .currency:
            delegate?.didSelectItem(item: currencies[indexPath.item])
            
        case .category:
            delegate?.didSelectItem(item: categories[indexPath.item])
        }
        _ = navigationController?.popViewController(animated: true)
    }
}


extension GenericSelectionVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else {return}
        // Do something here
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Do something here
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKey = searchBar.text, !searchKey.isEmpty else {
            return
        }
        // Do something here
    }
}
