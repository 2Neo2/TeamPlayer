//
//  NotificationCenter+ext.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 05.06.2024.
//

import Foundation

extension NotificationCenter {
    static let miniPlayerDidUpdate = Notification.Name("miniPlayerDidUpdate")
    static let miniPlayerHide = Notification.Name("miniPlayerHide")
    static let miniPlayerOpen = Notification.Name("miniPlayerOpen")
    static let updateHomveVC = Notification.Name("updateHomeRooms")
    static let updateRoomVC = Notification.Name("updateRoomVC")
    static let updateLibraryVC = Notification.Name("updateLibraryVC")
}
