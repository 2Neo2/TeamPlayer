//
//  MembersPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.05.2024.
//

import Foundation

protocol MembersPresenterProtocol {
    func hideView()
    func fetchData(with id: UUID)
}

final class MembersPresenter: MembersPresenterProtocol {
    weak var view: MembersViewController?
    var router: MembersRouter?
    private var roomService: RoomService = RoomService()
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchData(with id: UUID) {
        UIBlockingProgressHUD.show()
        guard let token = UserDataStorage().token else {
            return
        }
        roomService.membersInRoom(roomId: id.uuidString, token: token) { [weak self] result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.view?.updateUI(with: models)
                }
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
