//
//  MemberCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.05.2024.
//

import UIKit

class MembersCollectionViewCell: UICollectionViewCell {
    static let identifier = "MembersCollectionViewCell"
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var removeUserButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(removeUserButtonTapped), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private lazy var removeUserIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.removeUserIcon
        return imageView
    }()
    
    private lazy var changeUserAdminButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(changeUserAdminButtonTapped), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private lazy var changeUserAdminIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.userDjIcon
        return imageView
    }()
    
    private var currentModel: UserModel?
    var deleteAction: (() -> Void)?
    var setDjAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: UserModel) {
        userNameLabel.text = model.name
        if model.imageData.isEmpty == false {
            if let data = Data(base64Encoded: model.imageData) {
                userImageView.image = UIImage(data: data)
            }
        } else {
            self.userImageView.image = Constants.Images.defaultAccountIcon
        }
    }
    
    @objc
    private func removeUserButtonTapped() {
        if let action = self.deleteAction {
            action()
        }
    }
    
    @objc
    private func changeUserAdminButtonTapped() {
        if let action = self.setDjAction {
            action()
        }
    }
}

extension MembersCollectionViewCell {
    private func insertViews() {
        removeUserButton.addSubview(removeUserIcon)
        changeUserAdminButton.addSubview(changeUserAdminIcon)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(removeUserButton)
        contentView.addSubview(changeUserAdminButton)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        userImageView.pinTop(to: self.contentView, 13)
        userImageView.pinLeft(to: self.contentView, 13)
        userImageView.pinBottom(to: self.contentView, 13)
        userImageView.setWidth(50)
        
        userNameLabel.pinLeft(to: userImageView.trailingAnchor, 11)
        userNameLabel.pinCenterY(to: self.contentView)
        userNameLabel.setWidth(200)
        
        changeUserAdminButton.pinCenterY(to: contentView)
        changeUserAdminButton.pinRight(to: contentView, 15)
        changeUserAdminIcon.pin(to: changeUserAdminButton)
        
        removeUserButton.pinCenterY(to: contentView)
        removeUserButton.pinRight(to: changeUserAdminButton.leadingAnchor, 10)
        
        removeUserIcon.pin(to: removeUserButton)
    }
}
