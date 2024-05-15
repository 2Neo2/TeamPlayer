//
//  RegRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

protocol RegRouterProtocol {
    func openAuthFlow()
    func fetchUser()
    func openAuthFlowWithSnack()
}

final class RegRouter: RegRouterProtocol {
    weak var view: RegViewController?
    
    func openAuthFlow() {
        guard let view else {return}
        
        let presentVC = AuthConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openAuthFlowWithSnack() {
        guard let view else {return}
        
        let presentVC = AuthConfigurator.configure()
        SnackBar.make(in: presentVC.view, message: "Вы успешно зарегистрировались!", duration: .lengthLong).show()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func fetchUser() {
        
    }
}
