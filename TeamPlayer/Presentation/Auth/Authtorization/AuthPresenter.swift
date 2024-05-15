//
//  AuthPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol AuthPresenterProtocol {
    func openRegFlow()
    func fetchUser(with model: UserAuthModel)
}

final class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewController?
    var router: AuthRouter?
    private var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func openRegFlow() {
        router?.openRegFlow()
    }
    
    func fetchUser(with model: UserAuthModel) {
        UIBlockingProgressHUD.show()
        userService.fetchLoginUser(model: model) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    UIBlockingProgressHUD.dismiss()
                    self.router?.openHomeFlow()
                case .failure(let error):
                    UIBlockingProgressHUD.dismiss()
                    self.view?.showSomeError(with: error.localizedDescription)
                }
            }
        }
    }
}
