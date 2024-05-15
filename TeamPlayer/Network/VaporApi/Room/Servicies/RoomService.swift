//
//  RoomService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 16.04.2024.
//

import Foundation

protocol RoomServiceProtocol {
    func createRoom(model: RoomViewModel, token value: String, completion: @escaping (Result<String?, Error>) -> Void)
    func getRooms(token value: String, completion: @escaping (Result<[RoomModel], Error>) -> Void)
    func joinRoom(code invCode: String, token value: String, completion: @escaping (Result<JoinRoomModel, Error>) -> Void)
}

final class RoomService: RoomServiceProtocol {
    
    private let urlSession: URLSession = .shared

    func createRoom(model: RoomViewModel, token value: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "name": model.name,
            "isPrivate": model.isPrivate,
            "imageData": model.image
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = roomCreateRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<CreateRoomModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.invitationCode))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getRooms(token value: String, completion: @escaping (Result<[RoomModel], Error>) -> Void) {
        let request = roomAllRequest(token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[RoomModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func joinRoom(code invCode: String, token value: String, completion: @escaping (Result<JoinRoomModel, Error>) -> Void) {
        let json: [String: Any] = [
            "invitationCode": "\(invCode)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = joinRoomRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<JoinRoomModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func membersInRoom(roomId id: String, token value: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomId": id
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = listMembersRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[UserModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func listPublicRooms(token: String, completion: @escaping (Result<[RoomModel], Error>) -> Void) {
        let request = listPublicRoomsRequest(token: token)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[RoomModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension RoomService {
    private func roomCreateRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/create", httpMethod: "POST", body: body, token: token)
    }
    
    private func roomAllRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/list-all", httpMethod: "GET", token: token)
    }
    
    private func joinRoomRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/join-room", httpMethod: "POST", body: body, token: token)
    }
    
    private func listMembersRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/list-members", httpMethod: "GET", body: body, token: token)
    }
    
    private func listPublicRoomsRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/list-public", httpMethod: "GET", token: token)
    }
}
