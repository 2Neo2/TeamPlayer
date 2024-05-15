//
//  JoinConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 18.04.2024.
//

import UIKit

protocol JoinConfiguratorProtocol {
    static func configure(with delegate: JoinVCProtocol) -> UIViewController
}

final class JoinConfigurator: JoinConfiguratorProtocol {
    static func configure(with delegate: JoinVCProtocol) -> UIViewController {
        let view = JoinViewController()
        view.delegate = delegate
        let router = JoinRouter()
        let presenter = JoinPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
