//
//  AccountPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol AccountPresenterProtocol {
    func openSecurityFlow()
    func openUserDataFlow()
    func openAccessFlow()
    func opeHelpFlow()
    func fetchData()
}

final class AccountPresenter: AccountPresenterProtocol {
    weak var view: AccountViewController?
    var router: AccountRouter?
    private var profileStorage: ProfileServiceStorage
    
    init(profileStorage: ProfileServiceStorage) {
        self.profileStorage = profileStorage
    }
    
    func openSecurityFlow() {
        router?.openSecurityFlow(with: profileStorage)
    }
    
    func openUserDataFlow() {
        router?.openUserDataFlow(with: profileStorage)
    }
    
    func openAccessFlow() {
        router?.openAccessFlow(with: profileStorage)
    }
    
    func opeHelpFlow() {
        router?.opeHelpFlow()
    }
    
    func fetchData() {
        guard let userModel = profileStorage.currentProfile else { return }
        self.view?.updateData(with: userModel)
    }
}
