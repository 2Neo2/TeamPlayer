//
//  CreatePlaylistRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreatePlaylistRouterProtocol {
    func hideView()
}

final class CreatePlaylistRouter: CreatePlaylistRouterProtocol {
    weak var view: CreatePlaylistViewController?
    
    func hideView() {
        guard let view else {return}
        
        view.dismiss(animated: true)
    }
}
