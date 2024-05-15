//
//  FavouritesModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import Foundation

struct FavoritesTrackModel: Decodable {
    let skipped, count, total: Int
    let tracks: [TrackModel]

    enum CodingKeys: String, CodingKey {
        case skipped, count, total, tracks
    }
}
