//
//  RatingPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import Foundation

protocol RatingPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
    func fetchData()
}

final class RatingPresenter: RatingPresenterProtocol {
    weak var view: RatingViewController?
    var router: RatingRouter?
    
    
    func openMusicFlow() {
        router?.openMusicFlow()
    }
    
    func openRoomsFlow() {
        router?.openRoomsFlow()
    }
    
    func openAccountFlow() {
        router?.openAccountFlow()
    }
    
    func fetchData() {
        
    }
}
