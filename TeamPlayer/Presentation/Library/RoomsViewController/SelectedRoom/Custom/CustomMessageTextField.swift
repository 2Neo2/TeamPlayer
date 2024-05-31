//
//  CustomMessageTextField.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 28.05.2024.
//

import UIKit

final class CustomMessageTextField: UITextField {
    private var padding = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: 110)
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = Constants.Colors.general
        icon.image = Constants.Images.boltIcon
        return icon
    }()
    
    private lazy var sendbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.backgroundColor = Constants.Colors.general
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 15)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    var sendActionMessage: ((_ message: String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        insertViews()
        setupView()
        layoutView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func sendMessage() {
        if self.text != nil && self.text?.isEmpty == false {
            self.sendActionMessage?(self.text!)
            self.text = ""
        }
    }
    
    private func insertViews() {
        addSubview(iconView)
        addSubview(sendbutton)
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
        
        sendbutton.pinTop(to: self, 3)
        sendbutton.pinRight(to: self, 3)
        sendbutton.pinBottom(to: self, 3)
        sendbutton.setWidth(100)
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
