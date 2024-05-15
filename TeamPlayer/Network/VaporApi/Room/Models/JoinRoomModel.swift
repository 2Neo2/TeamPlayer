//
//  JoinRoomModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import Foundation

struct JoinRoomModel: Decodable {
    let id: UUID
    let name: String?
    let invitationCode: String
    let isPrivate: Bool
    let creator: UUID?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case invitationCode
        case isPrivate
        case creator
    }
}
