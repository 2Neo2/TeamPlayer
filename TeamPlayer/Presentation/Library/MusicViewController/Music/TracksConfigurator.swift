//
//  TracksConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 10.05.2024.
//

import UIKit

protocol TracksConfiguratorProtocol {
    static func configure(with model: PlaylistViewModel) -> UIViewController
}

final class TracksConfigurator: TracksConfiguratorProtocol {
    static func configure(with model: PlaylistViewModel) -> UIViewController {
        let view = TracksViewController()
        view.currentPlaylistModel = model
        let router = TracksRouter()
        let presenter = TracksPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
