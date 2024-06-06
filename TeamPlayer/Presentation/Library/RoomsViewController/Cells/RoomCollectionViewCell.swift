//
//  RoomCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.06.2024.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    static let identifier = "RoomCollectionViewCell"
    
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
    
    func configure(with model: RoomViewModel) {
        roomTitleLabel.text = model.name
        descriptionLabel.text = model.desctiption
        if let imageData = model.image, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                roomImageView.image = UIImage(data: data)
            }
        } else {
            roomImageView.image = Constants.Images.customRoomIcon
        }
    }
}

extension RoomCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomTitleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        roomImageView.pinTop(to: contentView, 10)
        roomImageView.pinLeft(to: contentView, 10)
        roomImageView.setWidth(120)
        roomImageView.pinBottom(to: contentView, 10)
        
        roomTitleLabel.pinTop(to: contentView, 13)
        roomTitleLabel.pinLeft(to: roomImageView.trailingAnchor, 9)
        roomTitleLabel.setWidth(140)
        
        descriptionLabel.pinLeft(to: roomImageView.trailingAnchor, 9)
        descriptionLabel.pinTop(to: roomTitleLabel.bottomAnchor, 2)
        descriptionLabel.setWidth(140)
    }
}
