//
//  RoomViewModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 16.04.2024.
//

import Foundation

struct RoomViewModel {
    var id: UUID
    var name: String
    var creatorID: UUID?
    var isPrivate: Bool
    var image: String?
    var desctiption: String
}
