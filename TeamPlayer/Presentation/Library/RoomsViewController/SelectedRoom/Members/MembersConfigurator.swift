//
//  MembersConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.05.2024.
//

import UIKit

protocol MembersConfiguratorProtocol {
    static func configure(with id: UUID) -> UIViewController
}

final class MembersConfigurator: MembersConfiguratorProtocol {
    static func configure(with id: UUID) -> UIViewController {
        let view = MembersViewController()
        view.currentId = id
        let router = MembersRouter()
        let presenter = MembersPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
