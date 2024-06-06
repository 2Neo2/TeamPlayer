//
//  LibraryPlaylistCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.06.2024.
//

import UIKit

class LibraryPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "LibraryPlaylistCollectionViewCell"
    
    private lazy var playlistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
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
    
    func configure(with model: PlaylistViewModel) {
        playlistNameLabel.text = model.name
        descriptionLabel.text = model.description
        
        if let imageData = model.imageData, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                playlistImageView.image = UIImage(data: data)
                return
            }
        }
        playlistImageView.image = Constants.Images.playlistDefault
    }
}

extension LibraryPlaylistCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Constants.Colors.general?.cgColor
    }
    
    private func layoutViews() {
        playlistImageView.pinTop(to: contentView, 10)
        playlistImageView.pinLeft(to: contentView, 10)
        playlistImageView.pinRight(to: contentView, 10)
        playlistImageView.pinBottom(to: contentView, 60)
        
        playlistNameLabel.pinTop(to: playlistImageView.bottomAnchor, 10)
        playlistNameLabel.pinLeft(to: contentView, 15)
        playlistNameLabel.setWidth(180)
        
        descriptionLabel.pinLeft(to: contentView, 15)
        descriptionLabel.pinTop(to: playlistNameLabel.bottomAnchor, 2)
        descriptionLabel.pinRight(to: contentView, 10)
    }
}
