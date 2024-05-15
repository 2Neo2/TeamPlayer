//
//  MainPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol MainPresenterProtocol {
    func openAuthFlow()
    func openRegFlow()
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewController?
    var router: MainRouter?
    
    
    func openAuthFlow() {
        router?.openAuthFlow()
    }
    
    func openRegFlow() {
        router?.openRegFlow()
    }
}
