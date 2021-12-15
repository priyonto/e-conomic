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
    
    // MARK: - VARIABLES
    
    var selectionState: SelectionState = .currency
    weak var delegate: GenericSelectionDelegate?
    
    /// Lazy loaded viewmodel
    lazy var viewModel = GenericSelectionViewModel(selectionState)
    
    // MARK: - UI Components
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
    
    /// collectionview to hold the list
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
    
    
    // MARK: - CONSTANTS

    let cellIdentifier: String = "cellIdentifier"
    let cellHeight: CGFloat = 60
    let spacing: CGFloat = 16




    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        bindViewModel()
    }

}

extension GenericSelectionVC {
    fileprivate func bindViewModel() {
        viewModel.currenciesSubscriber = { [weak self] _ in
            guard let self = self else {return}
            self.reload()
        }
        
        viewModel.categoriesSubscriber = { [weak self] _ in
            guard let self = self else {return}
            self.reload()
        }
    }
    
    fileprivate func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.collectionView.reloadData()
        }
    }
 
}
