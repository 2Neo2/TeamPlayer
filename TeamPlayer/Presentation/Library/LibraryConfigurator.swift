//
//  LibraryConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol LibraryConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class LibraryConfigurator: LibraryConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = LibraryViewController()
        let router = LibraryRouter()
        let presenter = LibraryPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
