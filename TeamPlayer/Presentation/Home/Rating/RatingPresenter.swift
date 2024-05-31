//
//  RatingPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import Foundation

protocol RatingPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
    func fetchData()
}

final class RatingPresenter: RatingPresenterProtocol {
    weak var view: RatingViewController?
    var router: RatingRouter?
    private var roomService = RoomService()
    
    func openMusicFlow() {
        router?.openMusicFlow()
    }
    
    func openRoomsFlow() {
        router?.openRoomsFlow()
    }
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func fetchData() {
        guard let token = UserDataStorage().token else { return }
        UIBlockingProgressHUD.show()
        roomService.getRoomsRating(with: token) { [weak self] result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.view?.configureUI(with: models)
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
