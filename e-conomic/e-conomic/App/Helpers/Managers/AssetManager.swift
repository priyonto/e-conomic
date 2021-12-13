//
//  AssetManager.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

let assetManager = AssetManager.shared

//
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

