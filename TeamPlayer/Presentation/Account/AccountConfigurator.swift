//
//  AccountConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol AccountConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class AccountConfigurator: AccountConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = AccountViewController()
        let router = AccountRouter()
        let userService = UserService()
        let profileStorage = ProfileServiceStorage(userService: userService)
        let presenter = AccountPresenter(profileStorage: profileStorage)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
