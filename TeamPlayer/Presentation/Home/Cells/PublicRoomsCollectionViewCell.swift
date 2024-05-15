//
//  PublicRoomsCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.05.2024.
//

import UIKit

class PublicRoomsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PublicRoomsCollectionViewCell"
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var roomTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.textColor = .black
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PublicRoomsCellViewModel) {
        roomTitleLabel.text = model.roomName
        if let imageData = model.img, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                roomImageView.image = UIImage(data: data)
            }
        } else {
            roomImageView.image = Constants.Images.customRoomIcon
        }
    }
}

extension PublicRoomsCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomTitleLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        roomImageView.pinTop(to: contentView, 10)
        roomImageView.pinLeft(to: contentView, 10)
        roomImageView.pinRight(to: contentView, 10)
        roomImageView.pinBottom(to: contentView, 60)
        
        roomTitleLabel.pinTop(to: roomImageView.bottomAnchor, 10)
        roomTitleLabel.pinLeft(to: contentView, 15)
    }
}

