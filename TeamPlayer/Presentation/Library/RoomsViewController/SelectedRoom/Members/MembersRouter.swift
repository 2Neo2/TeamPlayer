//
//  MembersRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.05.2024.
//

import UIKit

protocol MembersRouterProtocol {
    func hideView()
}

final class MembersRouter: MembersRouterProtocol {
    weak var view: MembersViewController?
    
    func hideView() {
        guard let view else {return}
        
        view.dismiss(animated: true)
    }
}
