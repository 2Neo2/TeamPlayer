//
//  JoinRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 18.04.2024.
//

import UIKit

protocol JoinRouterProtocol {
    func hideView()
}

final class JoinRouter: JoinRouterProtocol {
    weak var view: JoinViewController?
    
    func hideView() {
        guard let view else {return}
        
        view.dismiss(animated: true)
    }
}
