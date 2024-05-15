//
//  UserModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import Foundation

struct UserModel: Decodable {
    let id: UUID
    let name: String?
    let email: String?
    let plan: String?
    let passwordHash: String?
    let imageData: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case plan
        case passwordHash
        case imageData
    }
}
