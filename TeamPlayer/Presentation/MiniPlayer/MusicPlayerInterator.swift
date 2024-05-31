//
//  MusicPlayerInterator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.05.2024.
//

import Foundation

final class MusicPlayerInteractor: MusicPlayerBusinessLogic {
    // MARK: - Fields
    private let presenter: MusicPlayerPresentationLogic
    private let miniPlayerService: MiniPlayerProtocol
    
    // MARK: - Lifecycle
    init(
        presenter: MusicPlayerPresentationLogic,
        service: MiniPlayerProtocol = MiniPlayerService.shared
    ) {
        self.presenter = presenter
        self.miniPlayerService = service
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        self.miniPlayerService.getTrack() { track in
            DispatchQueue.main.async { [weak self] in
                let currentTrack = TrackViewModel(
                    id: track.trackID,
                    name: track.title,
                    artist: track.artist,
                    imageURL: track.img,
                    trackURL: track.downloadLink
                )
                self?.presenter.presentCurrent(Model.Current.Response(currentTrack: currentTrack))
            }
        }
       presenter.presentStart(Model.Start.Response())
    }
    
    func loadPlay(_ request: Model.Play.Request) {
        self.miniPlayerService.playTrack()
    }
    
    func loadPause(_ request: Model.Pause.Request) {
        self.miniPlayerService.pauseTrack()
    }
}
