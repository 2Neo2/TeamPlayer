//
//  PlayerRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit

protocol PlayerRouterProtocol {

}

final class PlayerRouter: PlayerRouterProtocol {
    weak var view: PlayerViewController?
    
    
    func hideView() {
        view?.dismiss(animated: true)
    }
}
