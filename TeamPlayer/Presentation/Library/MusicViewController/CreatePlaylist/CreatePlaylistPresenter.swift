//
//  CreatePlaylistPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import Foundation

protocol CreatePlaylistPresenterProtocol {
    func hideView()
    func fetchPlaylist(with model: PlaylistViewModel)
}

final class CreatePlaylistPresenter: CreatePlaylistPresenterProtocol {
    weak var view: CreatePlaylistViewController?
    var router: CreatePlaylistRouter?
    private var vaporService = PlaylistService()
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchPlaylist(with model: PlaylistViewModel) {
        guard let token = UserDataStorage().token else {
            return
        }
        
        vaporService.createPlaylist(model: model, token: token) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.hideView()
                }
                self?.view?.delegate?.playlistCreated()
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
