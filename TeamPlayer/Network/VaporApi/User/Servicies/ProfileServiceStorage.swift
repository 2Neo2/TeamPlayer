//
//  ProfileServiceStorage.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation

final class ProfileServiceStorage {
    private let userService: UserService?
    
    private var isDirty = false
    private var cachedProfile: UserModel?
    var userStorage: UserDataStorage
    
    var currentProfile: UserViewModel? {
        if cachedProfile == nil || isDirty {
            getProfile()
        }
        
        let result = makeModel(cachedProfile)
        return result
    }
    
    init(userService: UserService) {
        self.userService = userService
        self.userStorage = UserDataStorage()
    }
    
    func markDirty() {
        isDirty = true
    }
    
    func getProfile() {
        guard let token = userStorage.token else { return }
        userService?.fetchProfileUser(token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.cachedProfile = model
            case .failure:
                break
            }
        }
        isDirty = false
    }
    
    private func makeModel(_ model: UserModel?) -> UserViewModel? {
        guard let model = model else { return nil }
        return UserViewModel(
            name: model.name ?? "",
            email: model.email ?? "",
            plan: model.plan ?? "",
            imageData: model.imageData,
            password: model.passwordHash ?? ""
        )
    }
}
