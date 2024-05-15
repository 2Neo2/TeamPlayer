//
//  HelpConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol HelpConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class HelpConfigurator: HelpConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = HelpViewController()
        let router = HelpRouter()
        let presenter = HelpPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
