//
//  MusicPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol MusicPresenterProtocol {
    func openFavouritesFlow()
    func openCreateFlow()
    func openAccountFlow()
    func openPlaylistFlow(with model: PlaylistViewModel)
    func fetchData()
}

final class MusicPresenter: MusicPresenterProtocol {
    weak var view: MusicViewController?
    var router: MusicRouter?
    private var vaporService = PlaylistService()
    
    func openFavouritesFlow() {
        router?.openFavouritesFlow()
    }
    
    func openCreateFlow() {
        router?.openCreateFlow()
    }
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func openDownloadedFlow() {
        router?.openDownloadedFlow()
    }
    
    func openPlaylistFlow(with model: PlaylistViewModel) {
        router?.openPlaylistFlow(with: model)
    }
    
    func removePlaylist(with id: UUID) {
        guard let token = UserDataStorage().token else { return }
        
        vaporService.removePlaylist(token: token, playlistID: id) { [weak self] result in
            switch result {
            case .success(_):
                self?.fetchData()
                self?.view?.notifyObserves()
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else {
            return
        }
        
        let group = DispatchGroup()
        group.enter()
        
        var playlists: [PlaylistViewModel]?
        
        vaporService.getPlaylists(token: token) { result in
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
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let playlists = playlists
            else { return }
            self.view?.updateData(with: playlists)
        }
    }
}
