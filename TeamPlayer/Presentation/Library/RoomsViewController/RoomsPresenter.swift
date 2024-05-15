//
//  RoomsPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol RoomsPresenterProtocol {
    func openCreateFlow()
    func didRoomTapped(viewModel: RoomViewModel)
    func openAccountFlow()
    func openJoinFlow()
    func fetchData()
}

final class RoomsPresenter: RoomsPresenterProtocol {
    weak var view: RoomsViewController?
    var router: RoomsRouter?
    private var roomService: RoomService = RoomService()
    
    func openCreateFlow() {
        router?.openCreateFlow()
    }
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func openJoinFlow() {
        router?.openJoinFlow()
    }
    
    func didRoomTapped(viewModel: RoomViewModel) {
        router?.openRoomFlow(with: viewModel)
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else {
            return
        }
        roomService.getRooms(token: token) { [weak self] result in
            switch result {
            case .success(let models):
                let rooms = models.map {
                    RoomViewModel(
                        id: $0.id,
                        name: $0.name ?? "",
                        creatorID: $0.creator,
                        isPrivate: $0.isPrivate,
                        image: $0.imageData?.base64EncodedString()
                    )
                }
                
                DispatchQueue.main.async {
                    self?.view?.updateUI(with: rooms)
                }
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                break
            }
        }
    }
}
