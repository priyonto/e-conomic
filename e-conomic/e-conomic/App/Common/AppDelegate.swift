//
//  AppDelegate.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupKeyboardManager()
        setupEntryScreen()
        return true
    }

}

extension AppDelegate {
    
    // Keyboard manager initialization
    fileprivate func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
    
    // Expenses screen is the entry point of the application
    fileprivate func setupEntryScreen() {
        let navigationController = UINavigationController(rootViewController: ExpensesVC())
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
    }
}

