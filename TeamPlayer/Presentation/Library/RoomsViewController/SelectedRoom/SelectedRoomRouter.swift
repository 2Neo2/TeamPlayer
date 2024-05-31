//
//  SelectedRoomRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol SelectedRoomRouterProtocol {
    func openMusicFlow()
    func openMembersFlow(with id: UUID)
    func openSearchFlow()
}

final class SelectedRoomRouter: SelectedRoomRouterProtocol {
    weak var view: SelectedRoomViewController?
    
    func openMusicFlow() {
//        guard let view else {return}
//
//        let presentVC = MusicConfigurator.configure()
//
//        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openMembersFlow(with id: UUID) {
        guard let view else {return}

        let presentVC = MembersConfigurator.configure(with: id)
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openSearchFlow() {
        guard let view else {return}

        let presentVC = SearchConfigurator.configure(isFromAnotherView: true)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func hideView() {
        guard let view else {return}
        
        view.navigationController?.popViewController(animated: true)
    }
}
