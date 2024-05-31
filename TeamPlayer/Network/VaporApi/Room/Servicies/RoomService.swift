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
    func joinRoom(with id: String, code invCode: String, token value: String, completion: @escaping (Result<JoinRoomModel, Error>) -> Void)
}

final class RoomService: RoomServiceProtocol {
    
    private let urlSession: URLSession = .shared

    func createRoom(model: RoomViewModel, token value: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "name": model.name,
            "isPrivate": model.isPrivate,
            "imageData": model.image,
            "description": model.desctiption
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
    
    func joinRoom(with id: String, code invCode: String, token value: String, completion: @escaping (Result<JoinRoomModel, Error>) -> Void) {
        let json: [String: Any] = [
            "id": id,
            "invitationCode": invCode
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
    
    func joinRoomWithCode(code invCode: String, token value: String, completion: @escaping (Result<JoinRoomModel, Error>) -> Void) {
        let json: [String: Any] = [
            "invitationCode": invCode
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = joinRoomCodeRequest(body: jsonData, token: value)
        
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
    
    func membersInRoom(roomId id: String, token value: String, completion: @escaping (Result<[UserRoomModel], Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomId": id
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }

        
        let request = listMembersRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[UserRoomModel], Error>) in
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
    
    func exitRoom(with roomId: String, token value: String, completion: @escaping (Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomId": roomId
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = leaveRoomRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func closeRoom(with roomId: String, token value: String, completion: @escaping (Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomId": roomId
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = closeRoomRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func kickParticipant(with roomValue: String, userID userValue: String, token value: String, completion: @escaping (Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "roomId": roomValue,
            "userIdToKick": userValue
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = kickParticipantRoomRequest(body: jsonData, token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getRoomsRating(with token: String, completion: @escaping (Result<[RoomRatingModel], Error>) -> Void) {
        let request = getRatingRequest(token: token)
        let task = urlSession.objectTask(for: request) { (result: Result<[RoomRatingModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func changeUserRoomAdmin(with token: String, roomId valueRoom: String, userId valueUser: String, completion: @escaping(Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomId": valueRoom,
            "userId": valueUser
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = changeUserAdminRequest(body: jsonData, token: token)
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(_):
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func searchRoom(with token: String, name result: String, completion: @escaping(Result<[CreateRoomModel], Error>) -> Void) {
        let json: [String: Any] = [
            "name": result
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = searchRoomRequest(body: jsonData, token: token)
        let task = urlSession.objectTask(for: request) { (result: Result<[CreateRoomModel], Error>) in
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
    
    private func joinRoomCodeRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/join-room-code", httpMethod: "POST", body: body, token: token)
    }
    
    private func listMembersRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/list-members", httpMethod: "POST", body: body, token: token)
    }
    
    private func listPublicRoomsRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/list-public", httpMethod: "GET", token: token)
    }
    
    private func leaveRoomRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/leave-room", httpMethod: "DELETE", body: body, token: token)
    }
    
    private func closeRoomRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/close-room", httpMethod: "DELETE", body: body, token: token)
    }
    
    private func kickParticipantRoomRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/kick-participant", httpMethod: "DELETE", body: body, token: token)
    }
    
    private func getRatingRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/rating", httpMethod: "GET", token: token)
    }
    
    private func changeUserAdminRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/set-dj", httpMethod: "POST", body: body, token: token)
    }
    
    private func searchRoomRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/music-rooms/search", httpMethod: "POST", body: body, token: token)
    }
}
