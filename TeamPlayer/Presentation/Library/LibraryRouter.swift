//
//  LibraryRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol LibraryRouterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
}

final class LibraryRouter: LibraryRouterProtocol {
    weak var view: LibraryViewController?
    
    func openMusicFlow() {
        guard let view else {return}
        
        let presentVC = MusicConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openRoomsFlow() {
        guard let view else {return}
        
        let presentVC = RoomsConfigurator.configure(isFromAnotherView: true)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}

