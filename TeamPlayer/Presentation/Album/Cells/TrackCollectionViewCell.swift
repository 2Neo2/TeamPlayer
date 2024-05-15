//
//  TrackCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit
import Kingfisher

class TrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackCollectionViewCell"
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleMusicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var musicNoteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.musicNoteIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
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
    
    func configure(with model: TrackViewModel) {
        titleMusicLabel.text = model.name
        artistLabel.text = model.artist
        fetchImage(with: URL(string: model.imageURL)!) {
            print("Фото успешно загружено")
        }
    }
}

extension TrackCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(musicImageView)
        contentView.addSubview(titleMusicLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(musicNoteIcon)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Constants.Colors.general?.cgColor
    }
    
    private func layoutViews() {
        musicImageView.pinTop(to: self.contentView, 13)
        musicImageView.pinLeft(to: self.contentView, 13)
        musicImageView.pinBottom(to: self.contentView, 13)
        musicImageView.setWidth(50)
        
        titleMusicLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        titleMusicLabel.pinTop(to: self.contentView, 14)
        titleMusicLabel.setWidth(200)
        
        artistLabel.pinTop(to: titleMusicLabel.bottomAnchor, 2)
        artistLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        
        musicNoteIcon.pinCenterY(to: contentView)
        musicNoteIcon.pinRight(to: contentView, 15)
        musicNoteIcon.setWidth(30)
        musicNoteIcon.setHeight(30)
    }
    
    private func fetchImage(with url: URL,  completion: @escaping () -> Void) {
        musicImageView.kf.indicatorType = .activity
        musicImageView.kf.setImage(with: url) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                break
            }
        }
    }
}
