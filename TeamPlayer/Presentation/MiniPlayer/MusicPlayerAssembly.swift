//
//  MusicPlayerAssembly.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 07.05.2024.
//

import UIKit

enum MusicPlayerAssembly {
    static func build() -> UIView {
        let router: MusicPlayerRouter = MusicPlayerRouter()
        let presenter: MusicPlayerPresenter = MusicPlayerPresenter()
        let interactor: MusicPlayerInteractor = MusicPlayerInteractor(presenter: presenter)
        let view: UIView = MusicPlayerView(
            router: router,
            interactor: interactor
        )
        
        router.view = view
        presenter.view = view as? any MusicPlayerDisplayLogic
        
        return view
    }
}
