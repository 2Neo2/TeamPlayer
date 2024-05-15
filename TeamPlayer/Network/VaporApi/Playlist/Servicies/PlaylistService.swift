//
//  PlaylistService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import Foundation

protocol PlaylistServiceProtocol {
    func createPlaylist(model: PlaylistViewModel, token value: String, completion: @escaping (Result<String?, Error>) -> Void)
    func getPlaylists(token value: String, completion: @escaping (Result<[PlaylistModel], Error>) -> Void)
}

final class PlaylistService: PlaylistServiceProtocol {
    
    private let urlSession: URLSession = .shared

    func createPlaylist(model: PlaylistViewModel, token value: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "name": model.name,
            "imageData": model.imageData
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = playlistCreateRequest(body: jsonData, token: value)
        
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
    
    func getPlaylists(token value: String, completion: @escaping (Result<[PlaylistModel], Error>) -> Void) {
        let request = playlistAllRequest(token: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[PlaylistModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTracksPlaylist(with id: UUID, token value: String, completion: @escaping (Result<[MusicObjectModel], Error>) -> Void) {
        let json: [String: Any] = [
            "id": id.uuidString
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = playlistAllTracks(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[MusicObjectModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func addTrackToPlaylist(token value:String, with trackID: UUID, _ playlistID: UUID, completion: @escaping(Result<String, Error>) -> Void) {
        print(trackID)
        print(playlistID)
        let json: [String: Any] = [
            "trackID": trackID.uuidString,
            "playlistID": playlistID.uuidString
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = addTrackRequest(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success.message))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
        task.resume()
    }
    
    func removeTrack(token value: String, with trackID: UUID, completion: @escaping(Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "id": trackID.uuidString,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = removeTrackRequest(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success.message))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
        task.resume()
    }
    
    func storageTrack(token value: String, with model: TrackViewModel, completion: @escaping(Result<MusicObjectModel, Error>) -> Void) {
        let json: [String: Any] = [
            "trackID": "\(model.id)",
            "title": model.name,
            "artist": model.artist,
            "imgLink": model.imageURL,
            "musicLink": model.trackURL
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = storageTrackRequest(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<MusicObjectModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
        task.resume()
    }
    
    func removePlaylist(token value: String, playlistID id: UUID, completion: @escaping(Result<String, Error>) -> Void) {
        let json: [String: Any] = [
            "id": id.uuidString,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = removePlaylistRequest(token: value, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success.message))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
        task.resume()
    }
}

extension PlaylistService {
    private func playlistCreateRequest(body: Data?, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/create", httpMethod: "POST", body: body, token: token)
    }
    
    private func playlistAllRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/list-all", httpMethod: "GET", token: token)
    }
    
    private func playlistAllTracks(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/tracks", httpMethod: "POST", body: body, token: token)
    }
    
    private func addTrackRequest(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/add-track", httpMethod: "POST", body: body, token: token)
    }
    
    private func removeTrackRequest(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/remove-track", httpMethod: "DELETE", body: body, token: token)
    }
    
    private func storageTrackRequest(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/storage", httpMethod: "POST", body: body, token: token)
    }
    
    private func removePlaylistRequest(token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlists/remove-playlist", httpMethod: "DELETE", body: body, token: token)
    }
}



