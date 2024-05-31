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
    private var userService: UserService = UserService()
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchData(with id: UUID) {
        guard let token = UserDataStorage().token else {
            return
        }
        var users = [UserModel]()
        let group = DispatchGroup()
        
        group.enter()
        roomService.membersInRoom(roomId: id.uuidString, token: token) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                models.forEach { user in
                    group.enter()
                    self?.userService.fetchUserDataById(id: user.id) { result in
                        defer {
                            group.leave()
                        }
                        switch result {
                        case .success(let model):
                            if let model = model {
                                DispatchQueue.main.async {
                                    users.append(model)
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            self.view?.updateUI(with: users)
        }
    }
    
    func removeUser(_ roomID: UUID, _ userID: UUID) {
        guard let token = UserDataStorage().token else {
            return
        }
        
        roomService.kickParticipant(with: roomID.uuidString, userID: userID.uuidString, token: token) { [weak self] result in
            switch result {
            case .success(_):
                self?.fetchData(with: roomID)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func setdj(_ roomID: UUID, _ userID: UUID) {
        guard let token = UserDataStorage().token else {
            return
        }
        
        roomService.changeUserRoomAdmin(with: token, roomId: roomID.uuidString, userId: userID.uuidString) { result in
            switch result {
            case .success(_):
                print("ok")
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
