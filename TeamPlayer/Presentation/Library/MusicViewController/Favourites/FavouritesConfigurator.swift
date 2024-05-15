//
//  FavouritesConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol FavouritesConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class FavouritesConfigurator: FavouritesConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = FavouritesViewController()
        let router = FavouritesRouter()
        let presenter = FavouritesPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
