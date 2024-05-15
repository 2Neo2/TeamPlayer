//
//  MainConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol MainConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class MainConfigurator: MainConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = MainViewController()
        let router = MainRouter()
        let presenter = MainPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
