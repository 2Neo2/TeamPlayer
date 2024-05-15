//
//  HelpPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol HelpPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func fetchData()
}

final class HelpPresenter: HelpPresenterProtocol {
    weak var view: HelpViewController?
    var router: HelpRouter?
    
    
    func openMusicFlow() {
        //router?.openMusicFlow()
    }
    
    func openRoomsFlow() {
        //router?.openRoomsFlow()
    }
    
    func fetchData() {
        
    }
}
