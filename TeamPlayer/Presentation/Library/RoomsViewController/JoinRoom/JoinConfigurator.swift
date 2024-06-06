//
//  JoinConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 18.04.2024.
//

import UIKit

protocol JoinConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class JoinConfigurator: JoinConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = JoinViewController()
        let router = JoinRouter()
        let presenter = JoinPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
