//
//  UserDataRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol UserDataRouterProtocol {
    func hideView()
}

final class UserDataRouter: UserDataRouterProtocol {
    weak var view: UserDataViewController?
    
    func hideView() {
        guard let view else {return}
        
        view.navigationController?.popViewController(animated: true)
    }
}
