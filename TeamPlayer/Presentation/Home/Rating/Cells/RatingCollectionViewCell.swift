//
//  RatingCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit

class RatingItemViewCell: UICollectionViewCell {
    static let identifier = String(describing: RatingItemViewCell.self)
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameRoomLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var countMembersLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var musicRoomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.roomIcon
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupView()
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(
            top: 5.0, left: .zero, bottom: 5.0, right: .zero
        ))
    }

    func configureCell(with model: RoomRatingModel) {
        nameRoomLabel.text = model.name
        countMembersLabel.text = "Кол-во участников: \(model.countOfPeople)"
        if let imageData = model.imageData, imageData.isEmpty == false {
            roomImageView.image = UIImage(data: imageData)
        } else {
            roomImageView.image = Constants.Images.customRoomIcon
        }
    }
}

extension RatingItemViewCell {
    private func insertViews() {
        self.contentView.addSubview(roomImageView)
        self.contentView.addSubview(nameRoomLabel)
        self.contentView.addSubview(countMembersLabel)
        self.contentView.addSubview(musicRoomImageView)
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
        
        nameRoomLabel.pinLeft(to: roomImageView.trailingAnchor, 15)
        nameRoomLabel.pinTop(to: self.contentView, 10)
        
        countMembersLabel.pinTop(to: nameRoomLabel.bottomAnchor, 2)
        countMembersLabel.pinLeft(to: roomImageView.trailingAnchor, 15)
        
        musicRoomImageView.pinCenterY(to: self.contentView)
        musicRoomImageView.pinRight(to: self.contentView, 13)
    }
}
