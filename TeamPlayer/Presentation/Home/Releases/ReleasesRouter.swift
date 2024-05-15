//
//  ReleasesRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

protocol ReleasesRouterProtocol {
    func openSelectedRelease(with model: NewReleasesCellViewModel)
}

final class ReleasesRouter: ReleasesRouterProtocol {
    weak var view: ReleasesViewController?
    
    func openSelectedRelease(with model: NewReleasesCellViewModel) {
        guard let view else {return}
        
        let presentVC = AlbumConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
