//
//  AlbumModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import Foundation

struct AlbumModel: Decodable {
    let title, artists, img: String
    let trackCount: Int
    let tracks: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title
        case artists
        case img
        case trackCount = "track_count"
        case tracks
    }
}
