//
//  MainRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol MainRouterProtocol {
    func openAuthFlow()
    func openRegFlow()
}

final class MainRouter: MainRouterProtocol {
    weak var view: MainViewController?
    
    func openAuthFlow() {
        guard let view else {return}
        
        let presentVC = AuthConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openRegFlow() {
        guard let view else {return}
        
        let presentVC = RegConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
}
