//
//  SearchTextField.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

final class SearchTextField: UITextField {
    private var padding = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: 0)
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = Constants.Colors.boldGray
        icon.image = Constants.Images.searchButton
        return icon
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        insertViews()
        setupView()
        layoutView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func insertViews() {
        addSubview(iconView)
    }

    private func setupView() {
        backgroundColor = .white
    }
    
    private func layoutView() {
        iconView.setWidth(24)
        iconView.setHeight(24)
        iconView.pinTop(to: self, 5)
        iconView.pinLeft(to: self, 10)
        iconView.pinBottom(to: self, 5)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets.zero)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets.zero)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
