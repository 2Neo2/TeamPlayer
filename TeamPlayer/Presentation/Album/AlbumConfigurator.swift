//
//  AlbumConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol AlbumConfiguratorProtocol {
    static func configure(with model: NewReleasesCellViewModel) -> UIViewController
}

final class AlbumConfigurator: AlbumConfiguratorProtocol {
    static func configure(with model: NewReleasesCellViewModel) -> UIViewController {
        let view = AlbumViewController()
        view.currentModel = model
        let router = AlbumRouter()
        let presenter = AlbumPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
