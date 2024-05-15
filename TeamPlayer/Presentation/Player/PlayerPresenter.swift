//
//  PlayerPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import Foundation

protocol PlayerPresenterProtocol {
    func fetchData()
}

final class PlayerPresenter: PlayerPresenterProtocol {
    weak var view: PlayerViewController?
    var router: PlayerRouter?
    private var miniPlayerService = MiniPlayerService.shared
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        let currentTrack = self.miniPlayerService.getTrack() { track in
            DispatchQueue.main.async { [weak self] in
                let currentTrack = TrackViewModel(
                    id: track.trackID,
                    name: track.title,
                    artist: track.artist,
                    imageURL: track.img,
                    trackURL: track.downloadLink
                )
                self?.view?.updateTrack(with: currentTrack)
            }
        }
    }
}
