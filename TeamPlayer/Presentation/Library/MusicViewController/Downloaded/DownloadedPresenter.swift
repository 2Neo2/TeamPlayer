//
//  DownloadedPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import Foundation

protocol DownloadedPresenterProtocol {
    func fetchData()
}

final class DownloadedPresenter: DownloadedPresenterProtocol {
    weak var view: DownloadedViewController?
    var router: DownloadedRouter?
    private var vaporService = PlaylistService()
    
    func fetchData() {

    }
}
