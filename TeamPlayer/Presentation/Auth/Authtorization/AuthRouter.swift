//
//  AuthRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol AuthRouterProtocol {
    func openRegFlow()
    func openHomeFlow()
}

final class AuthRouter: AuthRouterProtocol {
    weak var view: AuthViewController?
    
    func openRegFlow() {
        guard let view else {return}
        
        let presentVC = RegConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openHomeFlow() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let tabBarController = CustomTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
