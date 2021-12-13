//
//  ExpensesVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//

import UIKit

class ExpensesVC: UIViewController {
    
    // MARK:- VARIABLES
    
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
    
    lazy var captureButton: UIButton = {
        let button = UIButton(image: assetManager.image(assetNamed: .camera), cornerRadius: 30)
        button.addTarget(self, action: #selector(handleCaptureButtonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK:- CONSTANTS
    
    fileprivate let cellIdentifier: String = "cellIdentifier"
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }

}


// MARK:- SETUP UI
extension ExpensesVC {
    fileprivate func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Expenses"
        
        
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
    
    fileprivate func registerCell() {
        collectionView.register(ExpenseCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension ExpensesVC {
    @objc fileprivate func handleCaptureButtonTap() {
        print("Tapped")
    }
}

// MARK:- UICOLLECTIONVIEW DELEGATE & DATA SOURCE
extension ExpensesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ExpenseCell else {
            fatalError()
        }
        return cell
    }
}

// MARK:- UICOLLECTIONVIEWDELEGAGEFLOWLAYOUT

extension ExpensesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 140
        let width: CGFloat = collectionView.bounds.width
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
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
