//
//  CreateRoomModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.04.2024.
//

import Foundation

struct CreateRoomModel: Codable {
    let isPrivate: Bool
    let name: String
    let imageData: Data
    let creator: Creator
    let invitationCode: String
    let usersInRoom: Int
    let id: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case invitationCode
        case isPrivate
        case creator
        case imageData
        case usersInRoom
    }
}

struct Creator: Codable {
    let id: UUID
}
