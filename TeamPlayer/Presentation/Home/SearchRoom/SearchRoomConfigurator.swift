//
//  SearchConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.05.2024.
//

import UIKit

protocol SearchRoomConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class SearchRoomConfigurator: SearchRoomConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = SearchRoomViewController()
        let router = SearchRoomRouter()
        let presenter = SearchRoomPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

