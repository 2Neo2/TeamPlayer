//
//  UIBlockingProgressHUD.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import ProgressHUD
import UIKit

final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.colorAnimation = .black
        ProgressHUD.animate("", AnimationType.activityIndicator)
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
