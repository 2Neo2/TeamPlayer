//
//  SelectedRoomPresenter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import Foundation
import AVFoundation

protocol SelectedRoomPresenterProtocol {
    func openMembersFlow(with id: UUID?)
    func fetchUserData(by id: UUID)
    func fetchChatHistory(by id: UUID?)
    func fetchRoomPlaylist(with id: UUID)
    func fetchMessage(with message: String, roomID room: UUID?)
}

final class SelectedRoomPresenter: SelectedRoomPresenterProtocol {
    weak var view: SelectedRoomViewController?
    var router: SelectedRoomRouter?
    private var userService = UserService()
    private var roomService = RoomService()
    private var socketChatManager = SocketManager()
    private var socketStreamManager = SocketManager()
    private var chatService = ChatService()
    private var audioBuffer: Data = Data()
    private let minBufferSize: Int = 4096 * 15
    private var player: AVPlayer!
    private var playerItem: AVPlayerItem!
    
    func openMembersFlow(with id: UUID?) {
        guard let id = id else { return }
        router?.openMembersFlow(with: id)
    }
    
    func exitRoom(with roomID: UUID, _ creator: UUID) {
        guard let userID = userService.userID, let token = userService.userToken else { return }
        if userID == creator.uuidString {
            roomService.closeRoom(with: roomID.uuidString, token: token) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.view?.notifyObserves()
                        self?.view?.notifyRoomObserves()
                        self?.view?.notifyLibraryObserves()
                        self?.hideView()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        } else {
            roomService.exitRoom(with: roomID.uuidString, token: token) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.view?.notifyRoomObserves()
                        self?.view?.notifyLibraryObserves()
                        self?.hideView()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func fetchRoomPlaylist(with id: UUID) {
        
    }
    
    private func playAudioData(data: Data) {
        audioBuffer.append(data)
        
        if data.isEmpty {
            playBufferedAudio()
        }
    }
    
    private func playBufferedAudio() {
        let temporaryDirectory = NSTemporaryDirectory()
        let filePath = (temporaryDirectory as NSString).appendingPathComponent("audioStream.mp3")
        let fileURL = URL(fileURLWithPath: filePath)
        
        do {
            try audioBuffer.write(to: fileURL)
        } catch {
            print("Failed to write audio data to file: \(error.localizedDescription)")
            return
        }
        
        playerItem = AVPlayerItem(url: fileURL)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    func fetchChatHistory(by id: UUID?) {
        guard let token = UserDataStorage().token,
              let roomId = id
        else { return }
        
        var resultData = [ChatMessageViewModel]()
        let group = DispatchGroup()
        group.enter()
        
        chatService.fetchChatHistory(token: token, with: roomId) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                models.forEach { model in
                    group.enter()
                    self?.userService.fetchUserByIdWithData(id: model.creator.id) { result in
                        defer {
                            group.leave()
                        }
                        switch result {
                        case .success(let user):
                            if let user = user {
                                DispatchQueue.main.async {
                                    resultData.append(ChatMessageViewModel(
                                        message: model.message,
                                        userId: user.id,
                                        userName: user.name ?? "",
                                        userImageData: user.imageData))
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        group.notify(queue: .main) {
            self.view?.updateMessageCollectionView(with: resultData)
        }
    }
    
    func connectToStream() {
        let link = Constants.Network.defaultVaporBaseURL + "/music-rooms/stream"
        guard let url = URL(string: link) else { return }
        
        self.socketStreamManager.connectToSocket(with: url)
        self.socketStreamManager.observeStreamCompletion { [weak self] data in
            guard let track = data else { return }
            self?.playAudioData(data: track)
        }
    }
    
    func connectToChat() {
        let link = Constants.Network.defaultVaporBaseURL + "/chats/connect"
        guard let url = URL(string: link) else { return }
        self.socketChatManager.connectToSocket(with: url)
        self.socketChatManager.observeMessages { [weak self] message in
            guard let line = message else { return }
            self?.userService.fetchUserByIdWithData(id: line.creator) { [weak self] result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        if let model = model {
                            DispatchQueue.main.async {
                                self?.view?.addMessageToCollectionView(message: ChatMessageViewModel(message: line.message, userId: model.id, userName: model.name ?? "", userImageData: model.imageData))
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func fetchStream() {
        socketStreamManager.sendStreamRequest(message: "1")
    }
    
    func fetchMessage(with message: String, roomID room: UUID?) {
        guard let userID = userService.userID, let roomID = room else { return }
        let model = ChatMessageModel(
            id: UUID(),
            message: message,
            creator: IdModel(id: UUID(uuidString: userID)!),
            musicRoom: IdModel(id: roomID)
        )
        socketChatManager.send(message: model)
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
