//
//  MusicPlayerModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.05.2024.
//

enum MusicPlayerModel {
    enum Start {
        struct Request { }
        
        struct Response {
            
        }
        
        struct ViewModel {
           
        }
    }
    
    enum Current {
        struct Response {
            var currentTrack: TrackViewModel
        }
        struct ViewModel { 
            var currentTrack:TrackViewModel
        }
    }

    enum Play {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
