//
//  UIViewController+Ext.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 27.09.2021.
//

import UIKit
import CDAlertView

extension UIViewController {
    
    func presentBAAlertOnMainThread(title: String, message: String, errorType: CDAlertViewType) {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: title, message: message, type: errorType)
            let doneAction = CDAlertViewAction(title: "OK")
            alert.add(action: doneAction)
            alert.show()
        }
    }
}
