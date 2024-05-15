//
//  CustomButtonContent.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.04.2024.
//

import UIKit

final class CustomButtonContent: UIButton {
    private lazy var typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var playView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = Constants.Colors.general
        return view
    }()
    private lazy var playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLabelItem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subtitleLabelItem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Light", size: 10)
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .left
        return label
    }()
    
    init(playIcon: UIImage, model: LibraryItemViewModel) {
        super.init(frame: .zero)
        insertViews()
        setupView(playIcon: playIcon, model: model)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButtonContent {
    private func insertViews() {
        addSubview(typeImageView)
        playView.addSubview(playImageView)
        addSubview(playView)
        addSubview(titleLabelItem)
        addSubview(subtitleLabelItem)
    }

    private func setupView(playIcon: UIImage, model: LibraryItemViewModel) {
        UIView.animate(withDuration: 0.3) {
            self.titleLabelItem.text = model.title
            self.subtitleLabelItem.text = model.subtitle
            self.playImageView.image = playIcon
            self.typeImageView.image = model.icon
            self.layoutIfNeeded()
        }
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            typeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            typeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            typeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            
            titleLabelItem.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            titleLabelItem.leadingAnchor.constraint(equalTo: typeImageView.trailingAnchor, constant: 10.0),
            
            subtitleLabelItem.topAnchor.constraint(equalTo: titleLabelItem.bottomAnchor, constant: 7.0),
            subtitleLabelItem.leadingAnchor.constraint(equalTo: typeImageView.trailingAnchor, constant: 10.0),
            
            playView.heightAnchor.constraint(equalToConstant: 42.0),
            playView.widthAnchor.constraint(equalToConstant: 42.0),
            playView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            playView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13.0),
            
            playImageView.centerXAnchor.constraint(equalTo: playView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: playView.centerYAnchor),
            playImageView.heightAnchor.constraint(equalToConstant: 20.0),
            playImageView.widthAnchor.constraint(equalToConstant: 20.0),
        ])
    }
}


