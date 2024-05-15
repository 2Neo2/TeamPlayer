//
//  CustomFavouritesButton.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

final class CustomFavouritesButton: UIButton {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.rightArrowIcon
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabelItem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        insertViews()
        self.titleLabelItem.text = title
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomFavouritesButton {
    private func insertViews() {
        addSubview(iconImageView)
        addSubview(titleLabelItem)
    }

    private func setupView() {
        layer.cornerRadius = 10
        backgroundColor = Constants.Colors.generalLight
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            titleLabelItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            titleLabelItem.topAnchor.constraint(equalTo: topAnchor, constant: 6.0),
            
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14.0),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 11.0)
        ])
    }
}


