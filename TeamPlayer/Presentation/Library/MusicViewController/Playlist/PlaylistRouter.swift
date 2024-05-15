//
//  PlaylistRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import Foundation

protocol PlaylistRouterProtocol {
    func openMusicFlow(with model: PlaylistViewModel)
}

final class PlaylistRouter: PlaylistRouterProtocol {
    weak var view: PlaylistViewController?
    
    func openMusicFlow(with model: PlaylistViewModel) {
        guard let view else {return}
        
        let presentVC = TracksConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
