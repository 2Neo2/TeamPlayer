//
//  UserDataConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol UserDataConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController
}

final class UserDataConfigurator: UserDataConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController {
        let view = UserDataViewController()
        let router = UserDataRouter()
        let presenter = UserDataPresenter(profileStorage: profileService)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
