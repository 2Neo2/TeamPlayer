//
//  SearchConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol SearchConfiguratorProtocol {
    static func configure(isFromAnotherView: Bool) -> UIViewController
}

final class SearchConfigurator: SearchConfiguratorProtocol {
    static func configure(isFromAnotherView: Bool) -> UIViewController {
        let view = SearchViewController()
        view.fromAnotherView = isFromAnotherView
        let router = SearchRouter()
        let presenter = SearchPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
