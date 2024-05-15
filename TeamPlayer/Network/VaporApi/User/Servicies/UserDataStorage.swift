//
//  UserDataStorage.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import Foundation
import SwiftKeychainWrapper

protocol UserDataStorageProtocol {
    var userID: String? { get set }
    var token: String? { get set }
    func removeUserID()
    func removeToken()
}

final class UserDataStorage: UserDataStorageProtocol {
    private var keyChain = KeychainWrapper.standard
    
    var userID: String? {
        get {
            keyChain.string(forKey: "userID")
        }
        
        set {
            guard let newValue = newValue else { return }
            keyChain.set(newValue, forKey: "userID")
        }
    }
    
    var token: String? {
        get {
            keyChain.string(forKey: "bearerToken")
        }
        
        set {
            guard let newValue = newValue else { return }
            keyChain.set(newValue, forKey: "bearerToken")
        }
    }
    
    func removeUserID() {
        keyChain.removeObject(forKey: "userID")
    }
    
    func removeToken() {
        keyChain.removeObject(forKey: "userID")
    }
}
