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
    
    public func get<T: Object>() -> [T] {

        let result = realm.objects(T.self)
        guard result.isEmpty == false else { return [] }
        let data: [T] = (0..<result.count).map { index in return result[index] }
        return data
    }
    
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

