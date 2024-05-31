//
//  TracksPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 10.05.2024.
//

import Foundation

protocol TracksPresenterProtocol {
    func fetchData()
}

final class TracksPresenter: TracksPresenterProtocol {
    weak var view: TracksViewController?
    var router: TracksRouter?
    private var yandexService = YandexMusicService()
    private var playlistService = PlaylistService()
    private var trackIds: String = "28472671,48591648,25693159,26728540,32771206,48591623,48591611,97416299,55698552,97416301,55698552,108719822,77208087,48591644,19676896,2193253,2193251,15282564,2193245,2193246,2215098,2216387,42953892,42953896,1695521,358612,358612,1695466"
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        yandexService.getPublicOnDayTracks() { result in
            switch result {
            case .success(let models):
                let tracks = models.map {
                    TrackViewModel(
                        id: $0.trackID,
                        name: $0.title,
                        artist: $0.artist,
                        imageURL: $0.img,
                        trackURL: $0.downloadLink,
                        duration: $0.duration
                    )
                }
                DispatchQueue.main.async {
                    self.view?.updateView(with: tracks)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addTrackToPlaylist(with model: TrackViewModel, playlistID value: UUID) {
        guard let token = UserDataStorage().token else { return }
        UIBlockingProgressHUD.show()
        playlistService.storageTrack(token: token, with: model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                playlistService.addTrackToPlaylist(token: token, with: model.id, value) { reslut in
                    switch result {
                    case .success(_):
                        print("ok")
                        UIBlockingProgressHUD.dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
