//
//  DateFormatter+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

// MARK: - DeteFormatter
/// Using this static instance saves cpu resources as creating dateformatter is a heavy operation
extension DateFormatter {
    static let dateTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df
    }()
}
