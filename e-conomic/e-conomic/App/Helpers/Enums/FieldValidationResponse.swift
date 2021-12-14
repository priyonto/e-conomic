//
//  FieldValidationResponse.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//


enum FieldName {
    case place_name
    case date
    case currency
    case amount
    case category
}

enum FieldValidationResponse {
    case success
    case failure(field: Field)
}

struct Field {
    let name: FieldName
    let message: String
}
