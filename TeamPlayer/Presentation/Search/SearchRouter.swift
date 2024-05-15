//
//  SearchRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol SearchRouterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
}

final class SearchRouter: SearchRouterProtocol {
    weak var view: SearchViewController?
    
    func openMusicFlow() {
//        guard let view else {return}
//
//        let presentVC = MusicConfigurator.configure()
//
//        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openRoomsFlow() {
//        guard let view else {return}
//
//        let presentVC = RoomsConfigurator.configure()
//
//        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
