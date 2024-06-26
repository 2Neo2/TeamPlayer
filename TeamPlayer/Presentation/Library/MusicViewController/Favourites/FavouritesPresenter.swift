//
//  FavouritesPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol FavouritesPresenterProtocol {
    func fetchData()
}

final class FavouritesPresenter: FavouritesPresenterProtocol {
    weak var view: FavouritesViewController?
    var router: FavouritesRouter?
    private var yandexService = YandexMusicService()
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        yandexService.getFavouritesTracks { [weak self] result in
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
                    self?.view?.updateTableView(with: tracks)
                }
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
            }
        }
    }
}
