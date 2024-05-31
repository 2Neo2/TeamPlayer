//
//  SearchPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.05.2024.
//

import Foundation

protocol SearchRoomPresenterProtocol {
    func fetchSearchData(with request: String)
    func openSingleFlow(with model: CreateRoomModel)
}

final class SearchRoomPresenter: SearchRoomPresenterProtocol {
    weak var view: SearchRoomViewController?
    var router: SearchRoomRouter?
    private var roomService = RoomService()
    
    func openSingleFlow(with model: CreateRoomModel) {
        guard let token = UserDataStorage().token else { return }
        roomService.joinRoom(with: model.id.uuidString, code: "", token: token) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.router?.openSingleFlow(with: model)
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            
        }
    }
    
    func fetchSearchData(with request: String) {
        guard let token = UserDataStorage().token else { return }
        
        roomService.searchRoom(with: token, name: request) { [weak self] result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.view?.updateUI(with: models)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
