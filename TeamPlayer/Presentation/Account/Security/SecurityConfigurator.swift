//
//  SecurityConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol SecurityConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController
}

final class SecurityConfigurator: SecurityConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController {
        let view = SecurityViewController()
        let router = SecurityRouter()
        let presenter = SecurityPresenter(profileStorage: profileService)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
