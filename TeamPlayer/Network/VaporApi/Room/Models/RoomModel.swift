//
//  RoomModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 16.04.2024.
//

import Foundation

struct RoomModel: Decodable {
    let id: UUID
    let name: String?
    let invitationCode: String
    let isPrivate: Bool
    let creator: UUID?
    let imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case invitationCode
        case isPrivate
        case creator
        case imageData
    }
}
