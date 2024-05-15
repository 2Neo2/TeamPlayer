//
//  EmailRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation

protocol EmailRouterProtocol {
    func hideView()
}

final class EmailRouter: EmailRouterProtocol {
    weak var view: EmailViewController?
    
    func hideView() {
        guard let view else {return}
        view.navigationController?.popViewController(animated: true)
    }
}
