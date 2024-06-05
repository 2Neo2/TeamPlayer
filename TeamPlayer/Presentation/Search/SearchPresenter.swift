//
//  SearchPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import Foundation

protocol SearchPresenterProtocol {
    func openAccountFlow()
    func fetchSearchData(with value: String)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewController?
    var router: SearchRouter?
    private var yandexService = YandexMusicService()
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func fetchSearchData(with value: String) {
        if value.isEmpty { return }
        yandexService.getSearchTracks(search: value) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let viewModel = TrackViewModel(
                    id: model.trackID,
                    name: model.title,
                    artist: model.artist,
                    imageURL: model.img,
                    trackURL: model.downloadLink,
                    duration: model.duration
                )
                DispatchQueue.main.async {
                    self.view?.updateUI(with: viewModel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchLike(with id: String) {
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
}
