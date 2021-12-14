//
//  RealmManager.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class RealmManager {
    
    public static let shared = RealmManager()
    private let queue = DispatchQueue(label: "RealmQueue", qos: .default, target: .main)
    
    // MARK: - Initializer
    
    private init() { }

    // MARK: - Public
    
    public func printRealmPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "N/A")
    }

    func get(_ T : Object.Type) -> [Object] {
        var objects = [Object]()
        for result in realm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func add(_ object : Object) {
        queue.sync {
            try! realm.write {
                realm.add(object)
            }
        }
    }
    
}

