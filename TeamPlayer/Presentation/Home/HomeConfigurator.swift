//
//  HomeConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol HomeConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class HomeConfigurator: HomeConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter()
        let presenter = HomePresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
