//
//  ExpenseViewModel.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import RealmSwift

class ExpenseViewModel: NSObject {

    var expenseListSubscriber: ((_ result: [Expense]) -> ())?
    var notificationToken: NotificationToken?
    
    override init() {
        super.init()
    }
}

extension ExpenseViewModel {
    
    func subscribeToChanges() {
        let results = realm.objects(Expense.StorageClass.self)
        notificationToken = results.observe { [weak self] _ in
            guard let self = self else {return}
            self.getExpenses()
        }
    }
    
    func getExpenses() {
        let objects: [Expense.StorageClass] = RealmManager.shared.get()
        let expenses = objects.map({ Expense.convertFromStorage($0)})
        expenseListSubscriber?(expenses)
    }
    
}
