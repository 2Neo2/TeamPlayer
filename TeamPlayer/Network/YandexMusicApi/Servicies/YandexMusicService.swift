//
//  YandexMusicService.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import Foundation

protocol YandexMusicServiceProtocol {
    func getFavouritesTracks(completion: @escaping (Result<[TrackModel], Error>) -> Void)
    func getSearchTracks(search value: String, completion: @escaping (Result<TrackModel, Error>) -> Void)
    func getNewReleases(count value: Int, completion: @escaping (Result<[NewReleasesCellViewModel], Error>) -> Void)
    func getTracksByIds(with ids: String, completion: @escaping(Result<[TrackModel], Error>) -> Void)
    func getTrackFromStation(completion: @escaping(Result<TrackModel, Error>) -> Void)
}

final class YandexMusicService: YandexMusicServiceProtocol {
    private let urlSession: URLSession = .shared
    
    func getFavouritesTracks(completion: @escaping (Result<[TrackModel], Error>) -> Void) {
        let request = favouritesSongsRequest(skip: 0, count: 25, token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<FavoritesTrackModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.tracks))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getPublicOnDayTracks(completion: @escaping (Result<[TrackModel], Error>) -> Void) {
        let request = playlistOfTheDayRequest(token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[TrackModel], Error>) in
            switch result {
            case .success(let models):
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getSearchTracks(search value: String, completion: @escaping (Result<TrackModel, Error>) -> Void) {
        let request = searchSongsRequest(value: value, token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<TrackModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getNewReleases(count value: Int, completion: @escaping (Result<[NewReleasesCellViewModel], Error>) -> Void) {
        let request = newReleasesRequest(skip: 0, count: value,token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[AlbumModel], Error>) in
            switch result {
            case .success(let model):
                let releases = model.map {
                    NewReleasesCellViewModel(
                        name: $0.title,
                        artistName: $0.artists,
                        count: $0.trackCount,
                        img: $0.img,
                        tracks: $0.tracks
                    )
                }
                completion(.success(releases))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTracksByIds(with ids: String, completion: @escaping(Result<[TrackModel], Error>) -> Void) {
        let request = tracksByIdsRequest(ids: ids, token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<[TrackModel], Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTrackFromStation(completion: @escaping(Result<TrackModel, Error>) -> Void) {
        let request = trackStationRequest(token: Constants.Network.yaToken)
        
        let task = urlSession.objectTask(for: request) { (result: Result<TrackModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func likeTrack(trackID value: String, completion: @escaping(Result<String, Error>) -> Void) {
        let request = likeRequest(token: Constants.Network.yaToken, value: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusTrackModel, Error>) in
            switch result {
            case .success(_):
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func dislikeTrack(trackID value: String, completion: @escaping(Result<String, Error>) -> Void) {
        let request = dislikeRequest(token: Constants.Network.yaToken, value: value)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusTrackModel, Error>) in
            switch result {
            case .success(_):
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension YandexMusicService {
    private func favouritesSongsRequest(skip: Int, count: Int, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/favourite_songs?skip=\(skip)&count=\(count)&ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func searchSongsRequest(value string: String, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/search?request=\(string)&ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func newReleasesRequest(skip: Int, count: Int, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/new_release?skip=\(skip)&count=\(count)&ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func tracksByIdsRequest(ids: String, token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/songs?track_ids=\(ids)&ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func trackStationRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/get_track_from_station?ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func likeRequest(token: String, value: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/like_track/\(value)?ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func dislikeRequest(token: String, value: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/dislike_track/\(value)?ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
    
    private func playlistOfTheDayRequest(token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/playlist_of_the_day?ya_token=\(token)", httpMethod: "GET", rote: Constants.Network.defaultYandexMusicBaseURL)
    }
}
