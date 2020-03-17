//
//  AlertManager.swift
//  BottomAlertSheet
//
//  Created by Decheng Ma on 17/3/20.
//  Copyright © 2020 Decheng Ma. All rights reserved.
//

import UIKit

public protocol AlertService {
    func performBottomAlert<T>(title: String, message: T, topButtons: [UIButton], bottomButtonTitle: String)
}

public class AlertManager: NSObject, AlertService {

    public func performBottomAlert<T>(title: String,
                               message: T,
                               topButtons: [UIButton],
                               bottomButtonTitle: String = "") {
        let alertView = BottomAlertView(title: title, message: message, topButtons: topButtons, bottomButtonTitle: bottomButtonTitle)
        alertView.present()
    }
}
