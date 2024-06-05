//
//  SocketManager.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 30.05.2024.
//

import Foundation
import Starscream


protocol SocketManagerProtocol {
    func connectToSocket(with url: URL)
    func send(message: ChatMessageModel)
    func observeMessages(completion: @escaping(MessageModel?) -> Void)
    func observeStreamCompletion(completion: @escaping(Data?) -> Void)
}

final class SocketManager: NSObject {
    private var isConnected: Bool = false
    private var socket: WebSocket!
    private var observingMessagesCompletion: ((MessageModel?) -> Void)?
    private var observingStreamCompletion: ((Data?) -> Void)?
}

extension SocketManager: SocketManagerProtocol {
    func connectToSocket(with url: URL) {
        var request = URLRequest(url: url)
        
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
        self.socket.connect()
    }
    
    func sendStreamRequest(message: String) {
        self.socket.write(string: message)
    }
    
    func send(message: ChatMessageModel) {
        let json: [String: Any] = [
            "message": message.message,
            "creator": message.creator.id.uuidString,
            "musicRoom": message.musicRoom.id.uuidString,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        if let data = jsonData {
            if let message = String(data: data, encoding: .utf8) {
                self.socket.write(string: message)
            }
        }
    }
    
    func observeMessages(completion: @escaping (MessageModel?) -> Void) {
        self.observingMessagesCompletion = completion
    }
    
    func observeStreamCompletion(completion: @escaping (Data?) -> Void) {
        self.observingStreamCompletion = completion
    }
}

extension SocketManager: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: any WebSocketClient) {
        switch event {
        case .connected(let headers):
            self.isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            self.isConnected = false
            print("websocket is disconnected: \(reason) with code \(code)")
        case .text(let text):
            guard let data = text.data(using: .utf8),
                  let messageModel = try? JSONDecoder().decode(MessageModel.self, from: data)else {
                print("error rr")
                break
            }
            observingMessagesCompletion?(messageModel)
        case .binary(let data):
            observingStreamCompletion?(data)
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            self.isConnected = false
        case .error(let error):
            self.isConnected = false
            print(error)
        case .peerClosed:
            self.isConnected = false
        }
    }
}
