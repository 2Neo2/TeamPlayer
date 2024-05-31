//
//  RoomRatingModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 23.05.2024.
//

import Foundation

struct RoomRatingModel: Decodable {
    let id: UUID
    let name: String?
    let invitationCode: String
    let isPrivate: Bool
    let creator: UUID?
    let imageData: Data?
    let countOfPeople: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case invitationCode
        case isPrivate
        case creator
        case imageData
        case countOfPeople
    }
}
