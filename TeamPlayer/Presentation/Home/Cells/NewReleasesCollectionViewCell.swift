//
//  NewReleasesCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.05.2024.
//

import UIKit
import Kingfisher

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    private lazy var releaseNameLabel: UILabel = {
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
    
    private lazy var countTracksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 8)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var releaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var releaseIcon: UIImageView = {
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
    
    func configure(with model: NewReleasesCellViewModel) {
        releaseNameLabel.text = model.name
        artistNameLabel.text = model.artistName
        countTracksLabel.text = "Кол-во треков: \(model.count)"
        fetchImage(with: URL(string: model.img)!) {
            print("Фото успешно загружено")
        }
    }
}

extension NewReleasesCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(releaseImageView)
        contentView.addSubview(releaseNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(countTracksLabel)
        contentView.addSubview(releaseIcon)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Constants.Colors.general?.cgColor
    }
    
    private func layoutViews() {
        releaseImageView.pinTop(to: contentView, 11)
        releaseImageView.pinLeft(to: contentView, 11)
        releaseImageView.setWidth(54)
        releaseImageView.setHeight(54)
        
        releaseNameLabel.pinTop(to: contentView, 8)
        releaseNameLabel.pinLeft(to: releaseImageView.trailingAnchor, 7)
        releaseNameLabel.pinRight(to: contentView, 7)
    
        artistNameLabel.pinTop(to: releaseNameLabel.bottomAnchor, 2)
        artistNameLabel.pinLeft(to: releaseImageView.trailingAnchor, 7)
        
        countTracksLabel.pinTop(to: artistNameLabel.bottomAnchor, 1)
        countTracksLabel.pinLeft(to: releaseImageView.trailingAnchor, 7)
        
        releaseIcon.pinCenterY(to: contentView)
        releaseIcon.pinRight(to: contentView, 15)
        releaseIcon.setWidth(30)
        releaseIcon.setHeight(30)
    }
    
    private func fetchImage(with url: URL,  completion: @escaping () -> Void) {
        releaseImageView.kf.indicatorType = .activity
        releaseImageView.kf.setImage(with: url) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                break
            }
        }
    }
}
