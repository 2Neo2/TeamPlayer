//
//  AccountRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol AccountRouterProtocol {
    func openSecurityFlow(with storage: ProfileServiceStorage)
    func openUserDataFlow(with storage: ProfileServiceStorage)
    func openAccessFlow(with storage: ProfileServiceStorage)
    func opeHelpFlow()
}

final class AccountRouter: AccountRouterProtocol {
    weak var view: AccountViewController?
    
    func openSecurityFlow(with storage: ProfileServiceStorage) {
        guard let view else {return}

        let presentVC = SecurityConfigurator.configure(profileService: storage)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openUserDataFlow(with storage: ProfileServiceStorage) {
        guard let view else {return}

        let presentVC = UserDataConfigurator.configure(profileService: storage)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openAccessFlow(with storage: ProfileServiceStorage) {
        guard let view else {return}

        let presentVC = AccessConfigurator.configure(profileService: storage)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func opeHelpFlow() {
        guard let view else {return}

        let presentVC = HelpConfigurator.configure()

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
