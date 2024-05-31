//
//  UIController+tabBar.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import UIKit

extension UIViewController {
    func createCustomTabBarLeftButton() {
        let button = UIBarButtonItem(image: Constants.Images.cancelIconCustom, style: .plain, target: self, action: #selector(backButtonTapped))
        button.tintColor = Constants.Colors.general
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func backButtonTapped() {
        if let value = MiniPlayerService.shared.markDirty {
            if value {
                MiniPlayerService.shared.markDirty = false
                MiniPlayerService.shared.pauseTrack()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
