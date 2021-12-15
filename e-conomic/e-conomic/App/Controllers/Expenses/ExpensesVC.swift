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
    

    // MARK: - UI COMPONENTS
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
    
    // Button
    lazy var captureButton: UIButton = {
        let button = UIButton(image: assetManager.image(assetNamed: .camera), cornerRadius: 30)
        button.addTarget(self, action: #selector(handleCaptureButtonTap), for: .touchUpInside)
        return button
    }()
    
    lazy var noResultsLbl = UILabel(text: "No expense record found.", textColor: .secondaryLabel, font: .AppleSDGothicNeo(.medium, size: 22), alignment: .center)
    
    // MARK: - CONSTANTS
    let viewModel = ExpenseViewModel()
    let cellIdentifier: String = "cellIdentifier"
    let picker = UIImagePickerController()
    let cellHeight: CGFloat = 140
    let spacing: CGFloat = 16
    

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
            self.reload()
        }
        
        viewModel.subscribeToChanges()
    }
}


// MARK: - Actions
extension ExpensesVC {
    
    /// 
    fileprivate func getExpenses() {
        viewModel.getExpenses()
    }
    
    fileprivate func reload() {
        
        if viewModel.expenses.count == 0 {
            self.noResultsLbl.isHidden = false
            self.collectionView.isHidden = true
        } else {
            self.noResultsLbl.isHidden = true
            self.collectionView.isHidden = false
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.collectionView.reloadData()
            }
        }
        
    }
    
    @objc fileprivate func handleCaptureButtonTap() {
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
            gotoAppPrivacySettings()
        }
        alert.addAction(openSettingsAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}




