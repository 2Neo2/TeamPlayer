//
//  MusicConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol MusicConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class MusicConfigurator: MusicConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = MusicViewController()
        let router = MusicRouter()
        let presenter = MusicPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
