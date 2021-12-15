//
//  RealmManager.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import RealmSwift

/// An instance of Realm to access Realm from different classes
let realm = try! Realm()

class RealmManager {
    
    public static let shared = RealmManager()

    // MARK: - Initializer
    
    private init() { }

    // MARK: - Public
    
    public func printRealmPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "N/A")
    }

    
    // MARK: - Get realm objects
    /// This method is used to get stored objects from realm database
    public func get<T: Object>() -> [T] {

        let result = realm.objects(T.self)
        guard result.isEmpty == false else { return [] }
        let data: [T] = (0..<result.count).map { index in return result[index] }
        return data
    }
    
    // MARK: - Store realm object
    /// This method is used to store single realm object to the realm database
    /// with a completion handler to notify when the operation completes with a boolean result
    func add(_ object : Object, completion: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.add(object)
                completion(true)
            }
        }
         catch {
            completion(false)
        }
    }
    
}

