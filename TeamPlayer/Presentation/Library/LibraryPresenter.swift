//
//  LibraryPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol LibraryPresenterProtocol {
    func openMusicFlow()
    func openRoomsFlow()
    func openAccountFlow()
    func fetchData()
}

final class LibraryPresenter: LibraryPresenterProtocol {
    weak var view: LibraryViewController?
    var router: LibraryRouter?
    
    
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
