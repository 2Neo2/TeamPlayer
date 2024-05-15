//
//  SecurityPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol SecurityPresenterProtocol {
    func openEmailFlow()
    func openPasswordFlow()
    func logoutFlow()
    func fetchData()
}

final class SecurityPresenter: SecurityPresenterProtocol {
    weak var view: SecurityViewController?
    var router: SecurityRouter?
    private var userService: UserService
    private var profileStorage: ProfileServiceStorage
    
    init(profileStorage: ProfileServiceStorage) {
        self.profileStorage = profileStorage
        self.userService = UserService()
    }
    
    func openEmailFlow() {
        router?.openEmailFlow(with: profileStorage)
    }
    
    func openPasswordFlow() {
        router?.openPasswordFlow(with: profileStorage)
    }
    
    func logoutFlow() {
        guard let token = profileStorage.userStorage.token else {
            return
        }
        userService.fetchLogoutUser(token: token) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.router?.logout()
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func fetchData() {
        guard let userModel = profileStorage.currentProfile else { return }
        self.view?.updateData(with: userModel)
    }
}
