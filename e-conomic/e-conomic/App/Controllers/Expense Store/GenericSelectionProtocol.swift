//
//  GenericSelectionProtocol.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

protocol GenericSelectionDelegate: NSObjectProtocol {
    func didSelectItem(item: Any)
}
