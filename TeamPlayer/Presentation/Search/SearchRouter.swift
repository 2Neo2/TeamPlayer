//
//  SearchRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol SearchRouterProtocol {
    func openAccountFlow()
}

final class SearchRouter: SearchRouterProtocol {
    weak var view: SearchViewController?
    
    func openAccountFlow() {
        guard let view else {return}
        
        let presentVC = AccountConfigurator.configure()
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
