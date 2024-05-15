//
//  AccessConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol AccessConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController
}

final class AccessConfigurator: AccessConfiguratorProtocol {
    static func configure(profileService: ProfileServiceStorage) -> UIViewController {
        let view = AccessViewController()
        let router = AccessRouter()
        let presenter = AccessPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
