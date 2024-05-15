//
//  HomeRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol HomeRouterProtocol {
    func openAccountFlow()
    func openSingleRoom(with model: RoomViewModel)
    func openPublicRoomsFlow()
    func openSingleRelease(with model: NewReleasesCellViewModel)
    func openReleasesFlow()
    func openRatingFlow()
}

final class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewController?
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
       
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openSingleRoom(with model: RoomViewModel) {
        guard let view else {return}
        
        let presentVC = SelectedRoomConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openPublicRoomsFlow() {
        guard let view else {return}
        
        let presentVC = PublicRoomsConfigurator.configure()
       
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openSingleRelease(with model: NewReleasesCellViewModel) {
        guard let view else {return}
        
        let presentVC = AlbumConfigurator.configure(with: model)
       
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openRatingFlow() {
        guard let view else {return}
        
        let presentVC = RatingConfigurator.configure()
       
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openReleasesFlow() {
        guard let view else {return}
        
        let presentVC = ReleasesConfigurator.configure()
       
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
