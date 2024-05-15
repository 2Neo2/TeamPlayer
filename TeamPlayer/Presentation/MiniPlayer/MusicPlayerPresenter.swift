//
//  MusicPlayerPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.05.2024.
//

import Foundation

final class MusicPlayerPresenter: MusicPlayerPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: MusicPlayerDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        
    }
    
    func presentCurrent(_ response: Model.Current.Response) {
        view?.displayStart(Model.Current.ViewModel(currentTrack: response.currentTrack))
    }
}
