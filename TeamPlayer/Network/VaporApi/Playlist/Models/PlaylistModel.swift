//
//  PlaylistModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import Foundation

struct PlaylistModel: Decodable {
    let id: UUID?
    let name: String
    let imageData: String
    let creatorID: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageData
        case creatorID
    }
}
