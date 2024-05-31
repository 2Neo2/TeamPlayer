//
//  SearchRoomViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.05.2024.
//

import UIKit

class SearchRoomCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchRoomCollectionViewCell"
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var roomIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.roomIconCell
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CreateRoomModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        if model.imageData.isEmpty == false {
            self.roomImageView.image = UIImage(data: model.imageData)
        } else {
            self.roomImageView.image = Constants.Images.customRoomIcon
        }
        
    }
}

extension SearchRoomCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(roomImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(roomIcon)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        roomImageView.pinTop(to: self.contentView, 13)
        roomImageView.pinLeft(to: self.contentView, 13)
        roomImageView.pinBottom(to: self.contentView, 13)
        roomImageView.setWidth(50)
        
        nameLabel.pinLeft(to: roomImageView.trailingAnchor, 11)
        nameLabel.pinTop(to: self.contentView, 14)
        nameLabel.setWidth(200)
        
        descriptionLabel.pinTop(to: nameLabel.bottomAnchor, 2)
        descriptionLabel.pinLeft(to: roomImageView.trailingAnchor, 11)
        
        roomIcon.pinCenterY(to: contentView)
        roomIcon.pinRight(to: contentView, 15)
        roomIcon.setWidth(30)
        roomIcon.setHeight(30)
    }
}
