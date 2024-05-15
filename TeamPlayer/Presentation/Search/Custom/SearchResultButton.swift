//
//  SearchResultView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 25.04.2024.
//

import UIKit
import Kingfisher

final class SearchResultButton: UIButton {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var trackIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var iconPlay: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.musicBarIcon
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultButton {
    private func insertViews() {
        addSubview(trackIcon)
        addSubview(nameLabel)
        addSubview(iconPlay)
        addSubview(artistLabel)
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        trackIcon.pinTop(to: self, 13)
        trackIcon.pinLeft(to: self, 13)
        trackIcon.pinBottom(to: self, 13)
        trackIcon.setWidth(50)
        
        nameLabel.pinLeft(to: trackIcon.trailingAnchor, 15)
        nameLabel.pinTop(to: self, 16)
        
        artistLabel.pinTop(to: nameLabel.bottomAnchor, 7)
        artistLabel.pinLeft(to: trackIcon.trailingAnchor, 11)
        
        iconPlay.pinTop(to: self, 16)
        iconPlay.pinRight(to: self, 13)
        iconPlay.pinBottom(to: self, 18)
        iconPlay.setWidth(42)
    }
}

extension SearchResultButton {
    func updateUI(with model: TrackViewModel) {
        UIView.animate(withDuration: 0.1) {
            self.nameLabel.text = model.name
            self.artistLabel.text = model.artist
            self.fetchImage(with: URL(string: model.imageURL)!) {
                print("Фото успешно загружено!")
            }
        }
    }
    
    private func fetchImage(with url: URL, completion: @escaping () -> Void) {
        trackIcon.kf.indicatorType = .activity
        trackIcon.kf.setImage(with: url) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                break
            }
        }
    }
}
