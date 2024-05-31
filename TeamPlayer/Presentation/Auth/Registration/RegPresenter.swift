//
//  RegPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol RegPresenterProtocol {
    func openAuthFlow()
    func fetchUser(with model: UserViewModel)
}

final class RegPresenter: RegPresenterProtocol {
    weak var view: RegViewController?
    var router: RegRouter?
    private var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func openAuthFlow() {
        router?.openAuthFlow()
    }
    
    func fetchUser(with model: UserViewModel) {
        userService.fetchRegisterUser(model: model) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.router?.openAuthFlowWithSnack()
                case .failure(let error):
                    self.view?.showSomeError(with: error.localizedDescription)
                }
            }
        }
    }
}
