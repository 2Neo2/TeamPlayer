//
//  MiniPlayerService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.05.2024.
//

import Foundation
import AVFoundation

protocol MiniPlayerProtocol {
    var currentTrack: TrackViewModel? { get set }
    func getTrack(completion: @escaping((TrackModel) -> Void))
    func playTrack()
    func pauseTrack()
}

final class MiniPlayerService: MiniPlayerProtocol {
    private let urlSession: URLSession = .shared
    private let yandexMusicService = YandexMusicService()
    
    private var isDirty = false
    private var cachedTrack: TrackModel?
    static var shared = MiniPlayerService()
    
    private var currentTime: CMTime = .zero
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var isPlay: Bool = false
    
    private init() { }
    
    var currentTrack: TrackViewModel? {
        get {
            if let model = self.cachedTrack {
                return TrackViewModel(
                    id: model.trackID,
                    name: model.title,
                    artist: model.artist,
                    imageURL: model.img,
                    trackURL: model.downloadLink,
                    duration: model.duration
                )
            } else {
                return nil
            }
        }
        
        set {
            if let model = newValue {
                self.cachedTrack = TrackModel(
                    trackID: model.id,
                    title: model.name,
                    artist: model.artist,
                    img: model.imageURL,
                    downloadLink: model.trackURL,
                    duration: model.duration!
                )
                self.currentTime = .zero
//                self.playTrack()
                notifyObserves()
            } else {
                self.cachedTrack = nil
            }
        }
    }
    
    var markDirty: Bool? {
        get {
            return self.isDirty
        }
        set {
            if let value = newValue {
                self.isDirty = value
                if value {
                    self.pauseTrack()
                    notifyObservesHide()
                } else {
                    notifyObservesOpen()
                }
            }
        }
    }

    func getTrack(completion: @escaping((TrackModel) -> Void)) {
        yandexMusicService.getTrackFromStation() { result in
            switch result {
            case .success(let model):
                self.currentTime = .zero
                self.cachedTrack = model
                completion(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func playTrack() {
        if let track = self.cachedTrack {
            if let url = URL(string: track.downloadLink) {
                playerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
                self.isPlay = true
                
                if !currentTime.seconds.isZero {
                    player?.seek(to: currentTime)
                }
                
                player?.play()
            }
        }
    }
    
    func pauseTrack() {
        player?.pause()
        
        self.isPlay = false
        self.currentTime = player?.currentTime() ?? .zero
    }
    
    private func notifyObserves() {
        NotificationCenter.default.post(name: NotificationCenter.miniPlayerDidUpdate, object: nil)
    }
    
    private func notifyObservesHide() {
        NotificationCenter.default.post(name: NotificationCenter.miniPlayerHide, object: nil)
    }
    
    private func notifyObservesOpen() {
        NotificationCenter.default.post(name: NotificationCenter.miniPlayerOpen, object: nil)
    }
}


extension NotificationCenter {
    static let miniPlayerDidUpdate = Notification.Name("miniPlayerDidUpdate")
    static let miniPlayerHide = Notification.Name("miniPlayerHide")
    static let miniPlayerOpen = Notification.Name("miniPlayerOpen")
}
