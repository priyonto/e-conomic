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

    /// notifier to notify when expense list is updated
    var expenseListSubscriber: ((_ result: [Expense]) -> ())?
    /// notifier of realm to notify viewmodel if any changes occure in the particular object
    var notificationToken: NotificationToken?
    
    // Variable
    var expenses: [Expense] = []
    
    override init() {
        super.init()
    }
}

extension ExpenseViewModel {
    /// Subscriber method for be reactive to the changes
    func subscribeToChanges() {
        let results = realm.objects(Expense.StorageClass.self)
        notificationToken = results.observe { [weak self] _ in
            guard let self = self else {return}
            self.getExpenses()
        }
    }
    /// Unsubscribe if not required
    func unsubscribe() {
        notificationToken = nil
    }
    
    /// Get expenses from local storage
    func getExpenses() {
        let objects: [Expense.StorageClass] = RealmManager.shared.get()
        let results = objects.map({ Expense.convertFromStorage($0)})
        expenses = results
        expenseListSubscriber?(expenses)
    }
    
}
