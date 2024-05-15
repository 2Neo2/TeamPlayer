//
//  HelpRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol HelpRouterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
}

final class HelpRouter: HelpRouterProtocol {
    weak var view: HelpViewController?
    
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
}
