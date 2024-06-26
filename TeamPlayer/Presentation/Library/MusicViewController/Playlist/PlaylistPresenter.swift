//
//  PlaylistPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import Foundation

protocol PlaylistPresenterProtocol {
    func openMusicFlow(with model: PlaylistViewModel)
    func fetchData(with playlistId: UUID?)
}

final class PlaylistPresenter: PlaylistPresenterProtocol {
    weak var view: PlaylistViewController?
    var router: PlaylistRouter?
    private var vaporService = PlaylistService()
    
    func openMusicFlow(with model: PlaylistViewModel) {
        router?.openMusicFlow(with: model)
    }
    
    func deleteTrackFromPlaylist(with playlistID: UUID?, in trackID: UUID) {
        guard let playlistID = playlistID, let token = UserDataStorage().token else { return }
        
        vaporService.removeTrack(token: token, with: trackID, playlistID: playlistID) { [weak self] result in
            switch result {
            case .success(_):
                self?.fetchData(with: playlistID)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchData(with playlistId: UUID?) {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token,
              let playlistId = playlistId else {
            return
        }
        
        let group = DispatchGroup()
        group.enter()
        
        var tracks: [MusicObjectViewModel]?
        vaporService.getTracksPlaylist(with: playlistId, token: token) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                tracks = models.map {                    
                    return MusicObjectViewModel(
                        id: $0.id,
                        trackID:$0.trackID,
                        name: $0.title,
                        artist: $0.artist,
                        imgURL: $0.imgLink,
                        musicURL: $0.musicLink,
                        duration: $0.duration
                    )
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let tracks = tracks
            else { return }
            self.view?.updateView(with: tracks)
        }
    }
}
