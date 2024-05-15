//
//  CreateRoomRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreateRoomRouterProtocol {
    func hideView()
}

final class CreateRoomRouter: CreateRoomRouterProtocol {
    weak var view: CreateRoomViewController?
    
    func hideView() {
        guard let view else {return}
        
        view.dismiss(animated: true)
    }
}
