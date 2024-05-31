//
//  MessageModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 31.05.2024.
//

import Foundation
struct MessageModel: Decodable {
    let message: String
    let creator: UUID
    let musicRoom: UUID
    
    enum CodingKeys: String, CodingKey {
        case message
        case creator
        case musicRoom
    }
}
