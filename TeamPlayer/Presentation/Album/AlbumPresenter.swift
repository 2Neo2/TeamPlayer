//
//  AlbumPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol AlbumPresenterProtocol {
    func fetchData()
}

final class AlbumPresenter: AlbumPresenterProtocol {
    weak var view: AlbumViewController?
    var router: AlbumRouter?
    private var yandexService = YandexMusicService()
    
    func fetchData() {
        guard let view = view, let model = view.currentModel else { return }
        UIBlockingProgressHUD.show()
        let ids = model.tracks.map { String($0) }.joined(separator: ",")
        
        let group = DispatchGroup()
        group.enter()
        
        var tracks: [TrackViewModel]?
        
        yandexService.getTracksByIds(with: ids) { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let models):
                tracks = models.map {
                    TrackViewModel(
                        id: $0.trackID,
                        name: $0.title,
                        artist: $0.artist,
                        imageURL: $0.img,
                        trackURL: $0.downloadLink,
                        duration: $0.duration
                    )
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard let tracks = tracks else { return }
            
            self.view?.configureData(tracks: tracks)
        }
    }
}
