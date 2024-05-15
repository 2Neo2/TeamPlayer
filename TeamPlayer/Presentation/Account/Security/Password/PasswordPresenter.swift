//
//  PasswordPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation

protocol PasswordPresenterProtocol {
    func fetchData(with newPassword: String, value oldPassword: String)
}

final class PasswordPresenter: PasswordPresenterProtocol {
    weak var view: PasswordViewController?
    var router: PasswordRouter?
    private var userService: UserService
    private var profileStorage: ProfileServiceStorage
    
    init(profileStorage: ProfileServiceStorage) {
        self.profileStorage = profileStorage
        self.userService = UserService()
    }
    
    func fetchData(with newPassword: String, value oldPassword: String) {
        guard let token = profileStorage.userStorage.token,
              let model = profileStorage.currentProfile,
              let id = profileStorage.userStorage.userID
        else {
            return
        }
        
//        if oldPassword != model.password {
//            return
//        }
//        
//        let updateModel = UserModel(
//            id: UUID(uuidString: id)!,
//            name: model.name,
//            email: model.email,
//            plan: model.plan,
//            passwordHash: newPassword
//        )
//        profileStorage.markDirty()
//        userService.fetchUpdateUser(model: updateModel, token: token) { [weak self] result in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                switch result {
//                case .success(_):
//                    self.router?.hideView()
//                case .failure:
//                    self.view?.showSomeError()
//                }
//            }
//        }
    }
}
