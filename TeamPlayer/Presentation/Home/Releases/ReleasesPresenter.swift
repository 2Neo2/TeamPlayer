//
//  ReleasesPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import Foundation

protocol ReleasesPresenterProtocol {
    func openSelectedRelease(with model: NewReleasesCellViewModel)
    func fetchData()
}

final class ReleasesPresenter: ReleasesPresenterProtocol {
    weak var view: ReleasesViewController?
    var router: ReleasesRouter?
    private var yandexService = YandexMusicService()
    
    func openSelectedRelease(with model: NewReleasesCellViewModel) {
        router?.openSelectedRelease(with: model)
    }
    
    func fetchData() {
        UIBlockingProgressHUD.show()
        
        let group = DispatchGroup()
        group.enter()
        
        var releases: [NewReleasesCellViewModel]?
        
        yandexService.getNewReleases(count: 30) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                releases = models
            case .failure(let error):
                print(error)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard
                let releases = releases
            else { return }
            
            self.view?.configureData(newReleases: releases)
        }
    }
}
