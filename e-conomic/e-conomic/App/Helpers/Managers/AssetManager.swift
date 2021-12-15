//
//  AssetManager.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

/// An instance of AssetManager to use AssetManager method across the application
let assetManager = AssetManager.shared


// MARK: - AssetManager
/// A class to handle resources of assets folder in a better way, skipping typing the name of the asset everywhere
/// This allows to create enum for asset and use them nicely throught the application
class AssetManager {
    static let shared = AssetManager()
    func image(assetNamed name: AssetName?) -> UIImage? {
        if let imageName = name?.rawValue {
            let image = UIImage(named: imageName)
            return image
        }
        return nil
    }
}

public enum AssetName: String, Codable {
    case camera = "camera"

}

