//
//  AppDelegate.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupEntryScreen()
        return true
    }

}

extension AppDelegate {
    fileprivate func setupEntryScreen() {
        window?.rootViewController = InitialVC()
    }
}

