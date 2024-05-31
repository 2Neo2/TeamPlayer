//
//  CreateRoomPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreateRoomPresenterProtocol {
    func hideView()
    func fetchRoom(with name: String, isPrivate value: Bool, image data: String?, description line: String)
}

final class CreateRoomPresenter: CreateRoomPresenterProtocol {
    weak var view: CreateRoomViewController?
    var router: CreateRoomRouter?
    private var roomsService: RoomService = RoomService ()
    private let pasteboard = UIPasteboard.general
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchRoom(with name: String, isPrivate value: Bool, image data: String?, description line: String) {
        guard let token = UserDataStorage().token else {
            return
        }
        
        roomsService.createRoom(model: RoomViewModel(
            id: UUID(),
            name: name,
            isPrivate: value,
            image: data, desctiption: line), token: token) { [weak self] result in
            switch result {
            case .success(let code):
                self?.pasteboard.string = code
                DispatchQueue.main.async {
                    self?.hideView()
                    self?.view?.delegate?.updateTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
