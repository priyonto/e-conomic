//
//  Protocol.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import RealmSwift
// MARK: - Protocol - Storable
/// This protocol is used to convert swift Decodable structs to RealmObject as well as RealmObject to Decodable
protocol Storable {
    associatedtype StorageClass: Object
    func convertToStorage() -> StorageClass
    static func convertFromStorage(_ storage: StorageClass) -> Self
}
