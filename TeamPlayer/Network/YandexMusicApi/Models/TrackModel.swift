//
//  TrackModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import Foundation

struct TrackModel: Decodable {
    let trackID: Int
    let title, artist: String
    let img, downloadLink: String

    enum CodingKeys: String, CodingKey {
        case trackID = "track_id"
        case title, artist, img
        case downloadLink = "download_link"
    }
}
