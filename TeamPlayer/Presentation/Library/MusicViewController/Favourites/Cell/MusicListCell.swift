//
//  MusicListCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit
import Kingfisher

final class MusicListCell: UITableViewCell {
    static let reuseIdentifier = "MusicListCell"
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleMusicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.textColor = .black
        label.numberOfLines = 0
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
        
        musicImageView.kf.cancelDownloadTask()
    }
    
    func configureCell(for model: TrackViewModel) {
        titleMusicLabel.text = model.name
        artistLabel.text = model.artist
        fetchImage(with: URL(string: model.imageURL)!) {
            print("Фото успешно загружено")
        }
        setupView()
        insertViews()
        layoutView()
    }
}

extension MusicListCell {
    private func insertViews() {
        self.contentView.addSubview(musicImageView)
        self.contentView.addSubview(titleMusicLabel)
        self.contentView.addSubview(artistLabel)
        self.contentView.addSubview(musicNoteIcon)
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 10
    }
    
    private func layoutView() {
        musicImageView.pinTop(to: self.contentView, 13)
        musicImageView.pinLeft(to: self.contentView, 13)
        musicImageView.pinBottom(to: self.contentView, 13)
        musicImageView.setWidth(50)
        
        titleMusicLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        titleMusicLabel.pinTop(to: self.contentView, 14)
        titleMusicLabel.setWidth(200)
        
        artistLabel.pinTop(to: titleMusicLabel.bottomAnchor, 2)
        artistLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        
        musicNoteIcon.pinCenterY(to: self.contentView)
        musicNoteIcon.pinRight(to: self.contentView, 15)
        musicNoteIcon.setWidth(30)
        musicNoteIcon.setHeight(30)
    }
    
    private func fetchImage(with url: URL, completion: @escaping () -> Void) {
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
