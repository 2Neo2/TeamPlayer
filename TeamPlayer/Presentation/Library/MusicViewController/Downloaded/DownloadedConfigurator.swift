//
//  DownloadedConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import UIKit

protocol DownloadedConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class DownloadedConfigurator: DownloadedConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = DownloadedViewController()
        let router = DownloadedRouter()
        let presenter = DownloadedPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
