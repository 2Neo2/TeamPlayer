//
//  HomePresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol HomePresenterProtocol {
    func openSingleRoom(with model: PublicRoomsCellViewModel)
    func openPublicRoomsFlow()
    func openSingleRelease(with model: NewReleasesCellViewModel)
    func openReleasesFlow()
    func openRatingFlow()
    func openAccountFlow()
    func fetchData()
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewController?
    var router: HomeRouter?
    private var vaporService = RoomService()
    private var yandexService = YandexMusicService()
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func openSingleRoom(with model: PublicRoomsCellViewModel) {
        let roomVM = RoomViewModel(
            id: model.id,
            name: model.roomName,
            creatorID: model.creator,
            isPrivate: model.isPrivate,
            image: model.img
        )
        
        router?.openSingleRoom(with: roomVM)
    }
    
    func openPublicRoomsFlow() {
        router?.openPublicRoomsFlow()
    }
    
    func openSingleRelease(with model: NewReleasesCellViewModel) {
        router?.openSingleRelease(with: model)
    }
    
    func openReleasesFlow() {
        router?.openReleasesFlow()
    }
    
    func openRatingFlow() {
        router?.openRatingFlow()
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else { return }
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        var publicRooms: [PublicRoomsCellViewModel]?
        var releases: [NewReleasesCellViewModel]?
        
        vaporService.listPublicRooms(token: token) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                publicRooms = models.map {
                    return PublicRoomsCellViewModel(
                        id: $0.id,
                        roomName: $0.name ?? "Without name",
                        code: $0.invitationCode,
                        isPrivate: $0.isPrivate,
                        creator: $0.creator ?? UUID(),
                        img: $0.imageData?.base64EncodedString()
                    )
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        yandexService.getNewReleases(count: 30) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                releases = models
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let publicRooms = publicRooms,
                let releases = releases
            else { return }
            
            self.view?.configureModels(publicRooms: publicRooms, newReleases: releases)
        }
    }
}
