//
//  PlaylistCollectionCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 10.05.2024.
//

import UIKit
import Kingfisher

class PlaylistCollectionCell: UICollectionViewCell {
    static let identifier = "PlaylistCollectionCell"
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var trackIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.albumIcon
        imageView.layer.cornerRadius = 6
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
    
    func configure(with model: MusicObjectViewModel) {
        trackNameLabel.text = model.name
        artistNameLabel.text = model.artist
        fetchImage(with: URL(string: model.imgURL)!) {
            print("Фото успешно загружено")
        }
    }
}

extension PlaylistCollectionCell {
    private func insertViews() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(trackIcon)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Constants.Colors.general?.cgColor
    }
    
    private func layoutViews() {
        trackImageView.pinTop(to: contentView, 11)
        trackImageView.pinLeft(to: contentView, 11)
        trackImageView.setWidth(54)
        trackImageView.setHeight(54)
        
        trackNameLabel.pinTop(to: contentView, 8)
        trackNameLabel.pinLeft(to: trackImageView.trailingAnchor, 7)
        trackNameLabel.pinRight(to: contentView, 7)
    
        artistNameLabel.pinTop(to: trackNameLabel.bottomAnchor, 2)
        artistNameLabel.pinLeft(to: trackImageView.trailingAnchor, 7)
        
        trackIcon.pinCenterY(to: contentView)
        trackIcon.pinRight(to: contentView, 15)
        trackIcon.setWidth(30)
        trackIcon.setHeight(30)
    }
    
    private func fetchImage(with url: URL,  completion: @escaping () -> Void) {
        trackImageView.kf.indicatorType = .activity
        trackImageView.kf.setImage(with: url) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                break
            }
        }
    }
}
