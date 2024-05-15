//
//  SecurityRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//
import UIKit

protocol SecurityRouterProtocol {
    func openEmailFlow(with profileStorage: ProfileServiceStorage)
    func openPasswordFlow(with profileStorage: ProfileServiceStorage)
    func logout()
}

final class SecurityRouter: SecurityRouterProtocol {
    weak var view: SecurityViewController?
    
    func openEmailFlow(with profileStorage: ProfileServiceStorage) {
        guard let view else {return}

        let presentVC = EmailConfigurator.configure(profileService: profileStorage)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func openPasswordFlow(with profileStorage: ProfileServiceStorage) {
        guard let view else {return}

        let presentVC = PasswordConfigurator.configure(profileService: profileStorage)

        view.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    func logout() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let presentVC = MainConfigurator.configure()
        window.rootViewController = presentVC
        window.makeKeyAndVisible()
    }
}
