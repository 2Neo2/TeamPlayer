//
//  AuthConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol AuthConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class AuthConfigurator: AuthConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = AuthViewController()
        let router = AuthRouter()
        let service = UserService()
        let presenter = AuthPresenter(userService: service)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
