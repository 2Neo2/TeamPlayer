//
//  MusicPlayerRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 07.05.2024.
//


import UIKit

final class MusicPlayerRouter: MusicPlayerRoutingLogic {
    weak var view: UIView?
    
    func routeToPlayer(with model: TrackViewModel?) {
        guard
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController,
            let model = model,
            let view = view
        else {
            return
        }
        
        let presentVC = PlayerConfigurator.configure(with: model, view as! ClosePlayerProtocol)
        rootViewController.present(presentVC, animated: true, completion: nil)
    }
}
