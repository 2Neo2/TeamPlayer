//
//  PasswordRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation

protocol PasswordRouterProtocol {
    func hideView()
}

final class PasswordRouter: PasswordRouterProtocol {
    weak var view: PasswordViewController?
    
    func hideView() {
        guard let view else {return}
        view.navigationController?.popViewController(animated: true)
    }
}

