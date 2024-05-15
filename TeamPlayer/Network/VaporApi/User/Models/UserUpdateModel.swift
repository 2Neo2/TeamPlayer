//
//  UserUpdateModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 16.04.2024.
//

import Foundation

struct UserUpdateModel: Decodable {
    let id: UUID
    let name: String?
    let email: String?
    let plan: String?
    let passwordHash: String?
    let old: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case plan
        case passwordHash
        case old
    }
}
