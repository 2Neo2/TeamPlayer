//
//  PasswordConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import UIKit

protocol PasswordConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController
}

final class PasswordConfigurator: PasswordConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController {
        let view = PasswordViewController()
        let router = PasswordRouter()
        let presenter = PasswordPresenter(profileStorage: profileService)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
