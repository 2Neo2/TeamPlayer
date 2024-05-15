//
//  UserTokenModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 12.04.2024.
//

import Foundation

struct UserTokenModel: Decodable {
    let id: UUID
    let value: String?
    let user: UserIdModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case user
    }
}

struct UserIdModel: Decodable {
    let id: UUID
}
