//
//  ExpensesVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//

import UIKit
import RealmSwift
import AVKit

class ExpensesVC: UIViewController {
    
    // MARK:- VARIABLES
    
    fileprivate var expenses: [Expense] = []
    
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
    
    fileprivate let viewModel = ExpenseViewModel()
    fileprivate let cellIdentifier: String = "cellIdentifier"
    fileprivate let picker = UIImagePickerController()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        bindViewModel()
    }

}

extension ExpensesVC {
    fileprivate func bindViewModel() {
        
        viewModel.expenseListSubscriber = { [weak self] (result) in
            guard let self = self else {return}
            self.expenses = result
            self.reload()
        }
        getExpenses()
    }
    
    fileprivate func getExpenses() {
        viewModel.getExpenses()
        viewModel.subscribeToChanges()
    }
    
    fileprivate func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.collectionView.reloadData()
        }
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
        // TODO:- HANDLE CAMERA & GALLERY PERMISSION PROPERLY
        // IMPORTANT!!!
        checkCameraPermission()
    }
    
    fileprivate func selectImageSource() {
        let alert = UIAlertController(title: nil, message: "Please Select Image Source", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [weak self] action in
            guard let self = self else {return}
            self.presentCameraController(.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default , handler:{ [weak self] action in
            guard let self = self else {return}
            self.presentCameraController(.photoLibrary)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func presentCameraController(_ source: UIImagePickerController.SourceType) {
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func checkCameraPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized, .notDetermined: selectImageSource()
        case .denied: askForCameraAccess()
        default: selectImageSource()
        }
    }

    
    fileprivate func askForCameraAccess() {
        let alert = UIAlertController(title: "Allow access to your photos",
                                      message: "This lets you capture image from camera or choose image from your photo library. Go to your settings and tap \"Photos\".",
                                      preferredStyle: .alert)
        
        let notNowAction = UIAlertAction(title: "Not Now",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(notNowAction)
        
        let openSettingsAction = UIAlertAction(title: "Open Settings",
                                               style: .default) { [unowned self] (_) in
            // Open app privacy settings
            gotoAppPrivacySettings()
        }
        alert.addAction(openSettingsAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ExpensesVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var image: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            image = possibleImage
        } else {
            return
        }

        picker.dismiss(animated: true)
        presentStoreExpenseScreen(image)
    }
}



// MARK:- UICOLLECTIONVIEW DELEGATE & DATA SOURCE
extension ExpensesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ExpenseCell else {
            fatalError()
        }
        cell.configure(from: expenses[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToExpenseDetailsScreen(expenses[indexPath.item])
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
