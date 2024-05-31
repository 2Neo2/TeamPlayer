//
//  ChatMessageCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 28.05.2024.
//

import UIKit

class ChatMessageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChatMessageCollectionViewCell"
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Font.getFont(name: "Bold", size: 13)
        label.numberOfLines = 0
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }

    
    func configureCell(with model: ChatMessageViewModel, adminId admin: UUID) {
        userNameLabel.text = model.userName
        messageLabel.text = model.message
        if !model.userImageData.isEmpty {
            if let data = Data(base64Encoded: model.userImageData) {
                self.userImageView.image = UIImage(data: data)
            }
        } else {
            self.userImageView.image = Constants.Images.defaultAccountIcon
        }
    }
}

extension ChatMessageCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(messageLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = Constants.Colors.general
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        userImageView.pinLeft(to: contentView, 5)
        userImageView.pinTop(to: contentView, 5)
        userImageView.pinBottom(to: contentView, 5)
        userImageView.setWidth(50)
        
        userNameLabel.pinTop(to: contentView, 5)
        userNameLabel.pinLeft(to: userImageView.trailingAnchor, 5)
        
        messageLabel.pinTop(to: userNameLabel.bottomAnchor, 5)
        messageLabel.pinLeft(to: userImageView.trailingAnchor, 5)
        messageLabel.setWidth(250)
    }
}
