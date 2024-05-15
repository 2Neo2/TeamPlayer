//
//  RoomsConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol RoomsConfiguratorProtocol {
    static func configure(isFromAnotherView value: Bool) -> UIViewController
}

final class RoomsConfigurator: RoomsConfiguratorProtocol {
    static func configure(isFromAnotherView value: Bool) -> UIViewController {
        let view = RoomsViewController()
        view.fromAnotherView = value
        let router = RoomsRouter()
        let presenter = RoomsPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
