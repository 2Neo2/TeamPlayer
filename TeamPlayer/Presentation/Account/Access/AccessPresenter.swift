//
//  AccessPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol AccessPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func fetchData()
}

final class AccessPresenter: AccessPresenterProtocol {
    weak var view: AccessViewController?
    var router: AccessRouter?
    
    
    func openMusicFlow() {
        //router?.openMusicFlow()
    }
    
    func openRoomsFlow() {
        //router?.openRoomsFlow()
    }
    
    func fetchData() {
        
    }
}
