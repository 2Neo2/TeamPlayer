//
//  PublicRoomsCellViewModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.05.2024.
//

import Foundation

struct PublicRoomsCellViewModel {
    let id: UUID
    let roomName: String
    let code: String
    let isPrivate: Bool
    let creator: UUID
    let img: String?
}
