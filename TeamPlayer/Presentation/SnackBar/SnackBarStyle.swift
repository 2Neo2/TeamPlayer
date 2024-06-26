//
//  SnackBarStyle.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit

public struct SnackBarStyle {
    public init() { }
    // Container
    public var background: UIColor = Constants.Colors.generalLight!
    var padding = 80
    var inViewPadding = 10
    // Label
    public var font: UIFont = Constants.Font.getFont(name: "Bold", size: 20)
    var maxNumberOfLines: UInt = 2
}
