//
//  PlaylistItemCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.04.2024.
//

import UIKit

class PlaylistItemViewCell: UICollectionViewCell {
    static let identifier = String(describing: PlaylistItemViewCell.self)
    
    private lazy var playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var playlistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var removePlaylistButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.general
        button.setTitle("удалить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 13)
        return button
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 10)
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .left
        return label
    }()
    
    private var currentModel: PlaylistViewModel?
    var deleteAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func removeButtonTapped() {
        if let action = self.deleteAction {
            action()
        }
    }

    func configureCell(with model: PlaylistViewModel) {
        playlistTitleLabel.text = model.name
        infoTitleLabel.text = "Плейлист: \(model.description)"
        if let imageData = model.imageData, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                playlistImageView.image = UIImage(data: data)
                return
            }
        }
        self.currentModel = model
        playlistImageView.image = Constants.Images.playlistDefault
    }
    
    private func insertViews() {
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistTitleLabel)
        contentView.addSubview(removePlaylistButton)
        contentView.addSubview(infoTitleLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        playlistImageView.pinTop(to: contentView, 10)
        playlistImageView.pinCenterY(to: contentView)
        playlistImageView.pinLeft(to: contentView, 10)
        playlistImageView.setWidth(56)
        
        playlistTitleLabel.pinTop(to: contentView, 13)
        playlistTitleLabel.pinLeft(to: playlistImageView.trailingAnchor, 5)
        
        infoTitleLabel.pinTop(to: playlistTitleLabel.bottomAnchor, 3)
        infoTitleLabel.pinLeft(to: playlistImageView.trailingAnchor, 5)
        infoTitleLabel.pinRight(to: contentView, 100)
        
        removePlaylistButton.pinCenterY(to: contentView)
        removePlaylistButton.pinRight(to: contentView, 15)
        removePlaylistButton.setWidth(80)
    }
}


