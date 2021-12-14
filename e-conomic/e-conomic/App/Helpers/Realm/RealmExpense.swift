//
//  RealmExpense.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import RealmSwift

class RealmExpense: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Int64 = 0
    @Persisted var place_name: String = ""
    @Persisted var currency: String = ""
    @Persisted var amount: Double = 0
    @Persisted var category: String = ""
    @Persisted var receipt_image_name: String = ""
    
}
