//
//  LibraryPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol LibraryPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
    func fetchData()
}

final class LibraryPresenter: LibraryPresenterProtocol {
    weak var view: LibraryViewController?
    var router: LibraryRouter?
    private var roomService = RoomService()
    private var playlistService = PlaylistService()
    
    func openSingleRoomFlow(with model: RoomViewModel) {
        router?.openSingleRoomFlow(with: model)
    }
    
    func openSinglePlaylistFlow(with playlist: PlaylistViewModel) {
        router?.openSinglePlaylistFlow(with: playlist)
    }
    
    func openMusicFlow() {
        router?.openMusicFlow()
    }
    
    func openRoomsFlow() {
        router?.openRoomsFlow()
    }
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func openFavouritesFlow() {
        router?.openFavouritesFlow()
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else { return }
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        var rooms: [RoomViewModel]?
        var playlists: [PlaylistViewModel]?
        
        roomService.getRooms(token: token) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                rooms = models.map {
                    RoomViewModel(
                        id: $0.id,
                        name: $0.name ?? "",
                        creatorID: $0.creator,
                        isPrivate: $0.isPrivate,
                        image: $0.imageData?.base64EncodedString(),
                        desctiption: $0.description
                    )
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        playlistService.getPlaylists(token: token) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                playlists = models.map {
                    return PlaylistViewModel(
                        id: $0.id!,
                        name: $0.name,
                        imageData: $0.imageData,
                        description: $0.description,
                        totalMinutes: $0.totalMinutes
                    )
                }
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let rooms = rooms,
                let playlists = playlists
            else { return }
            self.view?.updateDataOnView(with: rooms, and: playlists)
        }
    }
}
