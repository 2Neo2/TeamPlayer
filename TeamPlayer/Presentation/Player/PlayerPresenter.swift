//
//  PlayerPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.x
//

import Foundation

protocol PlayerPresenterProtocol {
    func fetchData()
}

final class PlayerPresenter: PlayerPresenterProtocol {
    weak var view: PlayerViewController?
    var router: PlayerRouter?
    private var yandexService = YandexMusicService()
    private var miniPlayerService = MiniPlayerService.shared
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        self.miniPlayerService.getTrack() { track in
            DispatchQueue.main.async { [weak self] in
                let currentTrack = TrackViewModel(
                    id: track.trackID,
                    name: track.title,
                    artist: track.artist,
                    imageURL: track.img,
                    trackURL: track.downloadLink,
                    duration: track.duration
                )
                self?.view?.updateTrack(with: currentTrack)
            }
        }
    }
    
    func playTrack() {
        self.miniPlayerService.playTrack()
    }
    
    func pauseTrack() {
        self.miniPlayerService.pauseTrack()
    }
    
    func likeTrack(with id: String) {
        UIBlockingProgressHUD.show()
        yandexService.likeTrack(trackID: id) { result in
            switch result {
            case .success(_):
                print("OK")
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func dislikeTrack(with id: String) {
        UIBlockingProgressHUD.show()
        yandexService.dislikeTrack(trackID: id) { result in
            switch result {
            case .success(_):
                print("OK")
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
