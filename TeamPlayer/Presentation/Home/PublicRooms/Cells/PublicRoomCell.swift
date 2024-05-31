//
//  PublicRoomCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit

class PublicRoomCell: UICollectionViewCell {
    static let identifier = "PublicRoomCell"
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var roomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var roomIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.roomIcon
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        roomTitleLabel.text = nil
        roomImageView.image = nil
        descriptionLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PublicRoomsCellViewModel) {
        roomTitleLabel.text = model.roomName
        descriptionLabel.text = model.desctiption
        if let imageData = model.img, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                roomImageView.image = UIImage(data: data)
            }
        } else {
            roomImageView.image = Constants.Images.customRoomIcon
        }
    }
}

extension PublicRoomCell {
    private func insertViews() {
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomTitleLabel)
        contentView.addSubview(roomIconView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        roomImageView.pinTop(to: contentView, 10)
        roomImageView.pinCenterY(to: contentView)
        roomImageView.pinLeft(to: contentView, 10)
        roomImageView.setWidth(56)
        
        roomTitleLabel.pinTop(to: contentView, 13)
        roomTitleLabel.pinLeft(to: roomImageView.trailingAnchor, 5)
        
        roomIconView.pinCenterY(to: contentView)
        roomIconView.pinRight(to: contentView, 30)
        
        descriptionLabel.pinLeft(to: roomImageView.trailingAnchor, 5)
        descriptionLabel.pinTop(to: roomTitleLabel.bottomAnchor, 2)
        descriptionLabel.pinRight(to: contentView, 50)
    }
}

