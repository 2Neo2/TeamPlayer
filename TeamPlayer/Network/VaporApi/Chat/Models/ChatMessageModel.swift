//
//  ChatMessageModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 27.05.2024.
//

import Foundation


struct ChatMessageModel: Decodable {
    let id: UUID
    let message: String
    let creator: IdModel
    let musicRoom: IdModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case creator
        case musicRoom 
    }
}

struct IdModel: Decodable {
    let id: UUID
}


