//
//  EmailConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import UIKit

protocol EmailConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController
}

final class EmailConfigurator: EmailConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController {
        let view = EmailViewController()
        let router = EmailRouter()
        let presenter = EmailPresenter(profileStorage: profileService)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
