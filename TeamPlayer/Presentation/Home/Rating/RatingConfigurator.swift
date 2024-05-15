//
//  RatingConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit

protocol RatingConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class RatingConfigurator: RatingConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = RatingViewController()
        let router = RatingRouter()
        let presenter = RatingPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

