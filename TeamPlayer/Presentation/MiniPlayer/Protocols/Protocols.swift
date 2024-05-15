//
//  Protocols.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.05.2024.
//

import Foundation

protocol MusicPlayerBusinessLogic {
    typealias Model = MusicPlayerModel
    func loadStart(_ request: Model.Start.Request)
    func loadPlay(_ request: Model.Play.Request)
    // func load(_ request: Model..Request)
}

protocol MusicPlayerPresentationLogic {
    typealias Model = MusicPlayerModel
    func presentStart(_ response: Model.Start.Response)
    func presentCurrent(_ response: Model.Current.Response)
    // func present(_ response: Model..Response)
}

protocol MusicPlayerDisplayLogic: AnyObject {
    typealias Model = MusicPlayerModel
    func displayStart(_ viewModel: Model.Current.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol MusicPlayerRoutingLogic {
    func routeToPlayer(with model: TrackViewModel?)
}
