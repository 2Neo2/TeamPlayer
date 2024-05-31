//
//  FavouritesRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol FavouritesRouterProtocol {
    func openMusicFlow()
}

final class FavouritesRouter: FavouritesRouterProtocol {
    weak var view: FavouritesViewController?
    
    func openMusicFlow() {
        guard let view else {return}
        
//     let presentVC = TracksConfigurator.configure()
//
//        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
