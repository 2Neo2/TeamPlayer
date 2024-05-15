//
//  Array+ext.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    func containsElement(_ element: Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
}
