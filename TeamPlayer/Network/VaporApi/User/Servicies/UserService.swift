//
//  AuthService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

protocol UserServiceProtocol {
    var userID: String? { get set }
    var userToken: String? { get set }
    func fetchRegisterUser(model: UserViewModel, completion: @escaping (Result<String?, Error>) -> Void)
    func fetchLoginUser(model: UserAuthModel, completion: @escaping (Result<String?, Error>) -> Void)
    func fetchProfileUser(token: String, completion: @escaping (Result<UserModel?, Error>) -> Void)
    func fetchUpdateUser(model: UserUpdateModel, token: String, completion: @escaping (Result<UserModel?, Error>) -> Void)
    func fetchLogoutUser(token: String, completion: @escaping (Result<String?, Error>) -> Void)
    func fetchUserById(id: UUID, completion: @escaping (Result<String?, Error>) -> Void) 
    func deleteToken()
}

final class UserService: UserServiceProtocol {
    private let urlSession: URLSession = .shared
    
    var userID: String? {
        get {
            UserDataStorage().userID
        }
        
        set {
            UserDataStorage().userID = newValue
        }
    }
    
    var userToken: String? {
        get {
            return UserDataStorage().token
        }
        
        set {
            UserDataStorage().token = newValue
        }
    }
    
    func deleteToken() {
        UserDataStorage().removeToken()
    }
    
    func fetchRegisterUser(model: UserViewModel, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "name": "\(model.name)",
            "email": "\(model.email)",
            "plan": "\(model.plan)",
            "password": "\(model.password)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = registerRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserModel, Error>) in
            switch result {
            case .success(let model):
                let userid = model.id.uuidString
                completion(.success(userid))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchLoginUser(model: UserAuthModel, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "email": "\(model.email)",
            "password": "\(model.password)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = loginRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserTokenModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let token = model.value
                self.userToken = token
                self.userID = model.user.id.uuidString
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchProfileUser(token: String, completion: @escaping (Result<UserModel?, Error>) -> Void) {
        let request = profileRequest(token: token)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchUpdateUser(model: UserUpdateModel, token: String, completion: @escaping (Result<UserModel?, Error>) -> Void) {
        let json: [String: Any?] = [
            "id": model.id,
            "name": model.name,
            "email": model.email,
            "plan": model.plan,
            "password": model.passwordHash,
            "old": model.old
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = profileUpdateRequest(body: jsonData, token: token)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchLogoutUser(token: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let request = logoutRequest(token: token)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<StatusModel?, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.deleteToken()
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchUserById(id: UUID, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any?] = [
            "id": "\(id)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = userByIdRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserModel?, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model?.name))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension UserService {
    private func registerRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/register", httpMethod: "POST", body: body)
    }
    
    private func loginRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/login", httpMethod: "POST", body: body)
    }
    
    private func profileRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/profile", httpMethod: "GET", token: token)
    }
    
    private func profileUpdateRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/update", httpMethod: "POST", body: body, token: token)
    }
    
    private func logoutRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/logout", httpMethod: "POST", token: token)
    }
    
    private func userByIdRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/userById", httpMethod: "POST", body: body)
    }
}
