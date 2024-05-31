//
//  ChatService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 30.05.2024.
//

import Foundation

protocol ChatServiceProtocol {
    func fetchChatHistory(token value: String, with roomID: UUID, completion: @escaping (Result<[ChatMessageModel], Error>) -> Void)
}

final class ChatService: ChatServiceProtocol {
    
    private let urlSession: URLSession = .shared
    
    func fetchChatHistory(token value: String, with roomID: UUID, completion: @escaping (Result<[ChatMessageModel], Error>) -> Void) {
        let json: [String: Any] = [
            "musicRoomID": roomID.uuidString
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = chatHistoryRequest(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[ChatMessageModel], Error>) in
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

extension ChatService {
    private func chatHistoryRequest(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/chats/history", httpMethod: "POST", body: body, token: token)
    }
}

