//
//  RoomListCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 17.04.2024.
//

import UIKit

final class RoomListCell: UITableViewCell {
    static let reuseIdentifier = "RoomListCell"
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameRoomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var musicRoomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.roomIcon
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        insertViews()
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(
            top: 10.0, left: .zero, bottom: 10.0, right: .zero
        ))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
    }
    
    func configureCell(for model: RoomViewModel) {
        nameRoomLabel.text = model.name
        descriptionLabel.text = model.desctiption
        if let imageData = model.image, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                roomImageView.image = UIImage(data: data)
            }
        } else {
            roomImageView.image = Constants.Images.customRoomIcon
        }
        insertViews()
        setupView()
        layoutView()
    }
}

extension RoomListCell {
    private func insertViews() {
        self.contentView.addSubview(roomImageView)
        self.contentView.addSubview(nameRoomLabel)
        self.contentView.addSubview(musicRoomImageView)
        self.contentView.addSubview(descriptionLabel)
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 10
    }
    
    private func layoutView() {
        roomImageView.pinTop(to: self.contentView, 13)
        roomImageView.pinLeft(to: self.contentView, 13)
        roomImageView.pinBottom(to: self.contentView, 13)
        roomImageView.setWidth(50)
        
        nameRoomLabel.pinLeft(to: roomImageView.trailingAnchor, 5)
        nameRoomLabel.pinTop(to: self.contentView, 16)
        nameRoomLabel.setWidth(180)
        
        musicRoomImageView.pinCenterY(to: self.contentView)
        musicRoomImageView.pinRight(to: self.contentView, 13)
        
        descriptionLabel.pinLeft(to: roomImageView.trailingAnchor, 5)
        descriptionLabel.pinTop(to: nameRoomLabel.bottomAnchor)
        descriptionLabel.pinRight(to: contentView, 50)
    }
}
