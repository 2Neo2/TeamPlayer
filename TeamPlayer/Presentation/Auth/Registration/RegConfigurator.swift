//
//  RegConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol RegConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class RegConfigurator: RegConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = RegViewController()
        let router = RegRouter()
        let service = UserService()
        let presenter = RegPresenter(userService: service)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
