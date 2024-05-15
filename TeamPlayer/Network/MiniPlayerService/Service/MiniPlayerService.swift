//
//  MiniPlayerService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.05.2024.
//

import Foundation
import AVFoundation

protocol MiniPlayerProtocol {
    var currentTrack: TrackViewModel? { get set}
    func getTrack(completion: @escaping((TrackModel) -> Void)) -> TrackModel?
    func markDirty()
}

final class MiniPlayerService: MiniPlayerProtocol {
    private let yandexMusicService = YandexMusicService()
    
    private var isDirty = false
    private var cachedTrack: TrackModel?
    static var shared = MiniPlayerService()
    
    private init() { }
    
    var currentTrack: TrackViewModel? {
        get {
            return makeModel(cachedTrack)
        }
        set {
            cachedTrack = TrackModel(
                trackID: newValue?.id ?? 0,
                title: newValue?.name ?? "",
                artist: newValue?.artist ?? "",
                img: newValue?.imageURL ?? "",
                downloadLink: newValue?.trackURL ?? ""
            )
        }
    }
    
    func markDirty() {
        isDirty = true
    }
    
    func getTrack(completion: @escaping((TrackModel) -> Void)) -> TrackModel? {
        var track: TrackModel?
        yandexMusicService.getTrackFromStation() { [weak self] result in
            switch result {
            case .success(let model):
                self?.cachedTrack = model
                completion(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return track
    }
    
    private func makeModel(_ model: TrackModel?) -> TrackViewModel? {
        guard let model = model else { return nil }
        return TrackViewModel(
            id: model.trackID,
            name: model.title,
            artist: model.artist,
            imageURL: model.img,
            trackURL: model.downloadLink
        )
    }
}
