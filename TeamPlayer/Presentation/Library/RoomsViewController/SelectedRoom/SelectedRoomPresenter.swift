//
//  SelectedRoomPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation

protocol SelectedRoomPresenterProtocol {
    func openMembersFlow(with id: UUID?)
    func openUserDataFlow()
    func openAccessFlow()
    func opeHelpFlow()
    func fetchUserData(by id: UUID)
}

final class SelectedRoomPresenter: SelectedRoomPresenterProtocol {
    weak var view: SelectedRoomViewController?
    var router: SelectedRoomRouter?
    private var userService = UserService()
    
    func openMembersFlow(with id: UUID?) {
        guard let id = id else { return }
        router?.openMembersFlow(with: id)
    }
    
    func openUserDataFlow() {
        //router?.openUserDataFlow()
    }
    
    func openAccessFlow() {
        //router?.openAccessFlow()
    }
    
    func opeHelpFlow() {
        //router?.opeHelpFlow()
    }
    
    func openSearchFlow() {
        router?.openSearchFlow()
    }
    
    func hideView() {
        router?.hideView()
    }
    
    func fetchUserData(by id: UUID) {
        userService.fetchUserById(id: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let name):
                DispatchQueue.main.async {
                    self.view?.updateDataOnView(with: name ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
