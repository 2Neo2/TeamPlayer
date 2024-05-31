//
//  PublicRoomsPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import Foundation

protocol PublicRoomsPresenterProtocol {
    func openSelectedRoom(with model: PublicRoomsCellViewModel)
    func fetchData()
}

final class PublicRoomsPresenter: PublicRoomsPresenterProtocol {
    weak var view: PublicRoomsViewController?
    var router: PublicRoomsRouter?
    private var vaporService = RoomService()
    
    func openSelectedRoom(with model: PublicRoomsCellViewModel) {
        let roomModel = RoomViewModel(
            id: model.id,
            name: model.roomName,
            creatorID: model.creator,
            isPrivate: model.isPrivate,
            image: model.img,
            desctiption: model.desctiption
        )
        router?.openSelectedRoom(with: roomModel)
    }
    
    func openSearchFlow() {
        router?.openSearchFlow()
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else { return }
        let group = DispatchGroup()
        group.enter()
        
        var publicRooms: [PublicRoomsCellViewModel]?
        
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
                        img: $0.imageData?.base64EncodedString(),
                        desctiption: $0.description
                    )
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let publicRooms = publicRooms
            else { return }
            self.view?.configureData(publicRooms: publicRooms)
        }
    }
}
