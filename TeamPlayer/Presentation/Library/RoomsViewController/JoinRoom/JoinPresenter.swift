//
//  JoinPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 18.04.2024.
//

import Foundation

protocol JoinPresenterProtocol {
    func hideView()
}

final class JoinPresenter: JoinPresenterProtocol {
    weak var view: JoinViewController?
    var router: JoinRouter?
    private var roomsService: RoomService = RoomService ()
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchRoom(with code: String) {
        guard let token = UserDataStorage().token else {
            return
        }
        
        roomsService.joinRoomWithCode(code: code, token: token) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.hideView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
