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
    
    /// Notify viewmodels to get the expense list from local database and
    /// view model notifes back the controller once the results are ready
    fileprivate func getExpenses() {
        viewModel.getExpenses()
    }
    
    /// Realods the view once viewmodel notifies the controller
    /// If the result is 0 a static label shows up
    /// Otherwise collectionview reloads
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
    
    /// The button on the bottom right tap fires this action
    /// It checks the camera permission of the user
    @objc fileprivate func handleCaptureButtonTap() {
        checkCameraPermission()
    }
    
    /// Present camera/photolibrary based on user selection
    fileprivate func presentCameraController(_ source: UIImagePickerController.SourceType) {
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    /// Checks for camera permission
    /// If user permits/permitted the access it opens up source selection alert
    /// Otherwise asks for permission
    func checkCameraPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized, .notDetermined: selectImageSource()
        case .denied: askForCameraAccess()
        default: selectImageSource()
        }
    }
    
    /// If access is denied previously it is required to take user to the settings app
    /// if they later wants to access the camera
    /// This method opens the iOS Settings app
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


extension ExpensesVC {
    
    /// Asks for camera access
    fileprivate func askForCameraAccess() {
        let alert = UIAlertController(title: Constants.imageAccessTitle,
                                      message: Constants.imageAccessMessage,
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
    
    /// This shows an action sheet to give users two choice of image course: Camera, Photo Library
    fileprivate func selectImageSource() {
        let alert = UIAlertController(title: nil, message: Constants.selectImageSource, preferredStyle: .actionSheet)
        
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
    
}

