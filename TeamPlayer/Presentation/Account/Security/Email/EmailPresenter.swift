//
//  EmailPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation

protocol EmailPresenterProtocol {
    func fetchData(with passwordUser: String, email value: String)
}

final class EmailPresenter: EmailPresenterProtocol {
    weak var view: EmailViewController?
    var router: EmailRouter?
    private var userService: UserService
    private var profileStorage: ProfileServiceStorage
    
    init(profileStorage: ProfileServiceStorage) {
        self.profileStorage = profileStorage
        self.userService = UserService()
    }
    
    func fetchData(with passwordUser: String, email value: String) {
        guard let token = profileStorage.userStorage.token,
              let id = profileStorage.userStorage.userID
        else {
            print("error data")
            return
        }
        
        let updateModel = UserUpdateModel(
            id: UUID(uuidString: id)!,
            name: nil,
            email: nil,
            plan: nil,
            passwordHash: nil,
            old: passwordUser
        )
        
        profileStorage.markDirty()
        userService.fetchUpdateUser(model: updateModel, token: token) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("ok")
                    self.router?.hideView()
                case .failure(let error):
                    print(error)
                    self.view?.showSomeError()
                }
            }
        }
    }
}
