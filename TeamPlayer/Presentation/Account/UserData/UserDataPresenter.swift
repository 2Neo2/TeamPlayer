//
//  UserDataPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol UserDataPresenterProtocol {
    func updateDataOnView()
    func fetchData(with name: String)
}

final class UserDataPresenter: UserDataPresenterProtocol {
    weak var view: UserDataViewController?
    var router: UserDataRouter?
    private var userService: UserService
    private var profileStorage: ProfileServiceStorage
    
    init(profileStorage: ProfileServiceStorage) {
        self.profileStorage = profileStorage
        self.userService = UserService()
    }
    
    func updateDataOnView() {
        guard let model = profileStorage.currentProfile else {
            return
        }
        
        view?.updateDataOnView(with: model.name)
    }
    
    func fetchData(with name: String) {
        guard let token = profileStorage.userStorage.token,
              let model = profileStorage.currentProfile,
              let id = profileStorage.userStorage.userID
        else {
            return
        }
        
//        let updateModel = UserUpdateModel(
//            id: UUID(uuidString: id)!,
//            name: name,
//            email: model.email,
//            plan: model.plan,
//            passwordHash: model.password
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
