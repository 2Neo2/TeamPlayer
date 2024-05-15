//
//  CustomTextFieldView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

final class CustomTextFieldView: UITextField {
    private var padding: UIEdgeInsets?
    
    private lazy var buttonIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonIconTapped), for: .touchUpInside)
        return button
    }()

    init(image: UIImage?, padding: UIEdgeInsets) {
        super.init(frame: .zero)
        if image != nil {
            insertViews()
            setupView(image: image!, padding: padding)
            layoutView()
        } else {
            self.padding = padding
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func insertViews() {
        addSubview(buttonIcon)
    }

    private func setupView(image: UIImage, padding: UIEdgeInsets) {
        self.padding = padding
        buttonIcon.setImage(image, for: .normal)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            buttonIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            buttonIcon.topAnchor.constraint(equalTo: topAnchor, constant: 12.0)
        ])
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
    
    @objc
    private func buttonIconTapped() {
        if isSecureTextEntry == false {
            isSecureTextEntry = true
        } else {
            isSecureTextEntry = false
        }
    }
}

