//
//  UIView+snapKit.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit
import SnapKit

extension UIView {
    func setupSubview(_ subview: UIView, setup: (ConstraintViewDSL) -> Void) {
        self.addSubview(subview)
        setup(subview.snp)
    }
}

