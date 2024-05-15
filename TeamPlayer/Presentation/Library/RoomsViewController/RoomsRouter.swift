//
//  RoomsRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol RoomsRouterProtocol {
    func openRoomFlow(with model: RoomViewModel)
    func openCreateFlow()
    func openAccountFlow()
    func openJoinFlow()
}

final class RoomsRouter: RoomsRouterProtocol {
    weak var view: RoomsViewController?
    
    func openRoomFlow(with model: RoomViewModel) {
        guard let view else {return}
        
        let presentVC = SelectedRoomConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openJoinFlow() {
        guard let view else {return}
        
        let presentVC = JoinConfigurator.configure(with: view.self)
        presentVC.modalPresentationStyle = .currentContext
        view.present(presentVC, animated: true)
    }
    
    func openCreateFlow() {
        guard let view else {return}
        
        let presentVC = CreateRoomConfigurator.configure(with: view.self)
        presentVC.modalPresentationStyle = .currentContext
        view.present(presentVC, animated: true)
    }
}
