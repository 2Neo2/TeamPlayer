//
//  PublicRoomsConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

protocol PublicRoomsConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class PublicRoomsConfigurator: PublicRoomsConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = PublicRoomsViewController()
        let router = PublicRoomsRouter()
        let presenter = PublicRoomsPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
