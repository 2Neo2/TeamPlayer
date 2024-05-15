//
//  PlayerConfiguration.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit

protocol PlayerConfiguratorProtocol {
    static func configure(with model: TrackViewModel, _ delegate: ClosePlayerProtocol) -> UIViewController
}

final class PlayerConfigurator: PlayerConfiguratorProtocol {
    static func configure(with model: TrackViewModel, _ delegate: ClosePlayerProtocol) -> UIViewController {
        let view = PlayerViewController()
        view.delegate = delegate
        view.currentModel = model
        let router = PlayerRouter()
        let presenter = PlayerPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
