//
//  MusicRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol MusicRouterProtocol {
    func openFavouritesFlow()
    func openCreateFlow()
    func openAccountFlow()
    func openDownloadedFlow()
    func openPlaylistFlow(with model: PlaylistViewModel)
}

final class MusicRouter: MusicRouterProtocol {
    weak var view: MusicViewController?
    
    func openFavouritesFlow() {
        guard let view else {return}
        
        let presentVC = FavouritesConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openCreateFlow() {
        guard let view else {return}
        
        let presentVC = CreatePlaylistConfigurator.configure(with: view)
        presentVC.modalPresentationStyle = .overCurrentContext
        view.present(presentVC, animated: true)
    }
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openDownloadedFlow() {
        guard let view else {return}
        
        let presentVC = DownloadedConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openPlaylistFlow(with model: PlaylistViewModel) {
        guard let view else {return}
        
        let presentVC = PlaylistConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
