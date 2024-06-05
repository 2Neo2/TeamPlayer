//
//  MusicObjectModel.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 15.05.2024.
//

import Foundation


struct MusicObjectModel: Decodable {
    var id: UUID
    var trackID: String
    var title: String
    var artist: String
    var imgLink: String
    var musicLink: String
    var duration: Int
}
