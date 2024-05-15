//
//  ReleasesConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

protocol ReleasesConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class ReleasesConfigurator: ReleasesConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = ReleasesViewController()
        let router = ReleasesRouter()
        let presenter = ReleasesPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
