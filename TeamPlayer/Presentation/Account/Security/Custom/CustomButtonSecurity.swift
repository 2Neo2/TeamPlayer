//
//  CustomButtonSecurity.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import UIKit

final class CustomButtonSecurity: UIButton {
    private struct ButtonConstants {
        static let trailingConstraint = -15.0
        static let topConstraint = 23.0
        static let leadingConstraint = 25.0
        static let bottomConstraint = -22.0
    }
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 17)
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Constants.Images.backwardIcon
        icon.tintColor = Constants.Colors.general
        return icon
    }()
    
    init(text labelText: String? = nil, image rightImage: UIImage? = nil) {
        super.init(frame: .zero)
        dataLabel.text = labelText
        if labelText == "Выйти" {
            dataLabel.textColor = .red
            dataLabel.font = Constants.Font.getFont(name: "Black", size: 17)
        } else {
            dataLabel.textColor = .black
        }
        
        if let rightImage = rightImage {
            iconView.image = rightImage
            iconView.tintColor = .red
        }
        
        setupView()
        addSubviews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButtonSecurity {
    private func setupView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(dataLabel)
        addSubview(iconView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            dataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ButtonConstants.leadingConstraint),
            dataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ButtonConstants.topConstraint),
            dataLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ButtonConstants.bottomConstraint),
            
            iconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ButtonConstants.trailingConstraint),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ButtonConstants.bottomConstraint),
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: ButtonConstants.topConstraint)
        ])
    }
    
    func setCustomTitile(with label: String) {
        dataLabel.text = label
    }
}
